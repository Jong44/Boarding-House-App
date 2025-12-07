import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/invoice_model.dart';
import 'package:boarding_house_app/utils/format_date.dart';
import 'package:flutter/material.dart';

class AdminTenantPaymentTab extends StatelessWidget {
  final ContractModel contract;

  const AdminTenantPaymentTab({super.key, required this.contract});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'partial':
        return Colors.orange;
      case 'unpaid':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'unpaid':
        return 'Belum Dibayar';
      case 'partial':
        return 'Lunas Sebagian';
      case 'paid':
        return 'Lunas';
      default:
        return 'Tidak Diketahui';
    }
  }

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final newestContract =
        contract.invoices != null && contract.invoices!.isNotEmpty
        ? contract.invoices!.reduce(
            (a, b) => a.issueDate.isAfter(b.issueDate) ? a : b,
          )
        : null;

    if (newestContract == null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 500),
        child: Container(
          margin: const EdgeInsets.all(16),
          height: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF5722), Color(0xFFFF7043)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Belum ada tagihan tersedia.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5722), Color(0xFFFF7043)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tagihan Terbaru',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatCurrency(newestContract.totalAmount.toInt() ?? 0),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(newestContract.status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getStatusText(newestContract.status),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Jatuh Tempo',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Text(
                          formatDate(newestContract.dueDate, withDayName: true),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('Riwayat Invoice'),
          contract.invoices != null && contract.invoices!.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    final InvoiceModel invoice =
                        contract.invoices != null &&
                            contract.invoices!.length > index
                        ? contract.invoices![index]
                        : InvoiceModel(
                            contractId: contract.id ?? 0,
                            issueDate: DateTime.now(),
                            dueDate: DateTime.now(),
                            totalAmount: 0,
                            status: 'Lunas',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          );
                    return _buildInvoiceItem(
                      'Invoice #${invoice.id ?? 'N/A'}',
                      '${formatDate(invoice.issueDate)} - ${formatDate(invoice.dueDate)}',
                      invoice.status,
                      invoice.totalAmount.toInt(),
                    );
                  },
                  itemCount: contract.invoices?.length ?? 0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )
              : Center(
                  child: Text(
                    'Tidak ada riwayat invoice.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildInvoiceItem(
    String invoiceNo,
    String period,
    String status,
    int amount,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoiceNo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  period,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _getStatusText(status),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatCurrency(amount),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
