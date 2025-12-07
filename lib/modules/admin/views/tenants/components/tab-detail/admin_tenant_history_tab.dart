import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/payment_model.dart';
import 'package:boarding_house_app/utils/format_currency.dart';
import 'package:boarding_house_app/utils/format_date.dart';
import 'package:flutter/material.dart';

class AdminTenantHistoryTab extends StatelessWidget {
  final ContractModel contract;
  const AdminTenantHistoryTab({super.key, required this.contract});
  //

  @override
  Widget build(BuildContext context) {
    // jumlah payment pada setiap invoice pada contract
    final List<PaymentModel> payments =
        contract.invoices
            ?.expand<PaymentModel>((invoice) => invoice.payments ?? [])
            .toList() ??
        [];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Riwayat Pembayaran'),
          if (payments.isEmpty)
            const Text('Belum ada riwayat pembayaran.')
          else
            ...payments.map(
              (payment) => _buildPaymentHistoryItem(
                formatDate(payment.paymentDate),
                'Pembayaran untuk Invoice #${payment.invoiceId}',
                payment.method,
                payment.amount.toInt(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryItem(
    String date,
    String description,
    String method,
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5722).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.receipt_long,
              color: Color(0xFFFF5722),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date • $method',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatCurrency(amount),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF059669),
            ),
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
