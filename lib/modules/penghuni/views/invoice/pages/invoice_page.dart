// Invoices Page
import 'package:boarding_house_app/modules/penghuni/views/invoice/pages/detail_invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({Key? key}) : super(key: key);

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _invoices = [
    {
      'code': 'INV-2025-00123',
      'period': 'January 2025 Boarding Fee',
      'room': 'Room A12',
      'total': 1500000,
      'paid': 0,
      'status': 'Unpaid',
      'dueDate': '12 Jan 2025',
    },
    {
      'code': 'INV-2025-00122',
      'period': 'December 2024 Boarding Fee',
      'room': 'Room A12',
      'total': 1500000,
      'paid': 600000,
      'status': 'Partial',
      'dueDate': '15 Dec 2024',
    },
    {
      'code': 'INV-2025-00121',
      'period': 'November 2024 Boarding Fee',
      'room': 'Room A12',
      'total': 1450000,
      'paid': 1450000,
      'status': 'Paid',
      'dueDate': '12 Nov 2024',
    },
  ];

  List<Map<String, dynamic>> get _filteredInvoices {
    if (_selectedFilter == 'All') return _invoices;
    return _invoices.where((inv) => inv['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Invoices',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lihat dan kelola tagihan kos Anda',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Unpaid'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Partial'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Paid'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Invoice List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredInvoices.length,
                itemBuilder: (context, index) {
                  return _buildInvoiceCard(_filteredInvoices[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B2C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF757575),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    final status = invoice['status'];
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

    final total = invoice['total'] as int;
    final paid = invoice['paid'] as int;
    final remaining = total - paid;
    final progress = paid / total;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InvoiceDetailPage(invoice: invoice),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Code & Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      invoice['code'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF757575),
                      ),
                    ),
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
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Period
                Text(
                  invoice['period'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),

                // Room
                Row(
                  children: [
                    Icon(
                      Icons.room_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      invoice['room'],
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Progress Bar (for Partial)
                if (status == 'Partial') ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Paid: Rp ${_formatCurrency(paid)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            ),
                          ),
                          Text(
                            'Remaining: Rp ${_formatCurrency(remaining)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFFF9800),
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],

                // Amount & Due Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${_formatCurrency(total)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Due Date',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              invoice['dueDate'],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // CTA Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InvoiceDetailPage(invoice: invoice),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: status == 'Paid'
                          ? Colors.grey[200]
                          : const Color(0xFFFF6B2C),
                      foregroundColor: status == 'Paid'
                          ? const Color(0xFF757575)
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      status == 'Paid' ? 'View Detail' : 'Pay Now',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
