import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PaymentModal extends StatefulWidget {
  final int amount;

  const PaymentModal({Key? key, required this.amount}) : super(key: key);

  @override
  State<PaymentModal> createState() => _PaymentModalState();
}

class _PaymentModalState extends State<PaymentModal> {
  String _selectedMethod = 'Bank Transfer';
  late TextEditingController _amountController;
  File? _paymentProof;

  Future<void> _pickPaymentProof() async {
    // Implement file picker logic here using immage_picker or file_picker package
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _paymentProof = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.amount.toString());
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              const Text(
                'Payment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Outstanding Balance: Rp ${_formatCurrency(widget.amount)}',
                style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
              const SizedBox(height: 24),

              // Amount Input
              const Text(
                'Payment Amount',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: 'Rp ',
                  hintText: 'Enter amount',
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Payment Method
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 12),
              _buildPaymentMethodOption('Bank Transfer', Icons.account_balance),
              _buildPaymentMethodOption('QRIS', Icons.qr_code_2),
              _buildPaymentMethodOption('Virtual Account', Icons.credit_card),
              const SizedBox(height: 24),

              const Text(
                'Upload Payment Proof',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: _pickPaymentProof,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFCCCCCC)),
                  ),
                  child: _paymentProof == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.upload_file,
                              size: 40,
                              color: Color(0xFF757575),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Tap to upload payment proof',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        )
                      : Image.file(_paymentProof!, fit: BoxFit.cover),
                ),
              ),

              const SizedBox(height: 24),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle payment
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment process initiated'),
                        backgroundColor: Color(0xFF4CAF50),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B2C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Confirm Payment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(String method, IconData icon) {
    final isSelected = _selectedMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = method;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF6B2C).withOpacity(0.1)
              : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF6B2C) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFFFF6B2C)
                  : const Color(0xFF757575),
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              method,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFFFF6B2C)
                    : const Color(0xFF1A1A1A),
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFFF6B2C),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
