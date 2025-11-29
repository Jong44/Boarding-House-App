// Invoice Detail Page
import 'dart:io';

import 'package:boarding_house_app/modules/penghuni/views/invoice/components/payment_modal.dart';
import 'package:flutter/material.dart';

class InvoiceDetailPage extends StatelessWidget {
  final Map<String, dynamic> invoice;

  const InvoiceDetailPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = invoice['status'];
    final total = invoice['total'] as int;
    final paid = invoice['paid'] as int;
    final remaining = total - paid;

    Color statusColor;
    Color statusBgColor;

    switch (status) {
      case 'Paid':
        statusColor = const Color(0xFF4CAF50);
        statusBgColor = const Color(0xFF4CAF50).withOpacity(0.1);
        break;
      case 'Partial':
        statusColor = const Color(0xFFFF9800);
        statusBgColor = const Color(0xFFFF9800).withOpacity(0.1);
        break;
      default:
        statusColor = const Color(0xFFF44336);
        statusBgColor = const Color(0xFFF44336).withOpacity(0.1);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Invoice Detail',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice['code'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusBgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        invoice['period'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Invoice Summary
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Invoice Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Room', invoice['room']),
                  const SizedBox(height: 12),
                  _buildInfoRow('Due Date', invoice['dueDate']),
                  const SizedBox(height: 12),
                  _buildInfoRow('Total Amount', 'Rp ${_formatCurrency(total)}'),
                  if (paid > 0) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow('Amount Paid', 'Rp ${_formatCurrency(paid)}'),
                  ],
                  if (remaining > 0) ...[
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Remaining Balance',
                      'Rp ${_formatCurrency(remaining)}',
                      valueColor: const Color(0xFFFF6B2C),
                      bold: true,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),
            // Payment History
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (paid > 0) ...[
                    _buildPaymentHistoryItem(
                      '10 Jan 2025',
                      'Bank Transfer',
                      600000,
                      'Success',
                    ),
                    if (status == 'Paid')
                      _buildPaymentHistoryItem(
                        '15 Jan 2025',
                        'QRIS',
                        900000,
                        'Success',
                      ),
                  ] else
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'No payment has been made yet.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Additional Info
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Generated Date', '1 Jan 2025'),
                  const SizedBox(height: 12),
                  _buildInfoRow('Created By', 'System / Admin'),
                  const SizedBox(height: 12),
                  const Text(
                    'Notes',
                    style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Denda dikenakan karena pembayaran terlambat 5 hari dari tanggal jatuh tempo.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: status != 'Paid'
          ? Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () {
                    _showPaymentModal(context, remaining);
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
                    'Pay Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Color? valueColor,
    bool bold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? const Color(0xFF1A1A1A),
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBreakdownItem(String item, int qty, int price, int total) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              item,
              style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              qty > 1 ? '$qty x' : '1x',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _formatCurrency(price),
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              _formatCurrency(total),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryItem(
    String date,
    String method,
    int amount,
    String status,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF4CAF50),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Rp ${_formatCurrency(amount)}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentModal(BuildContext context, int amount) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentModal(amount: amount),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

// Payment Modal
