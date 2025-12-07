import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/utils/format_date.dart';
import 'package:flutter/material.dart';

class AdminTenantContractTab extends StatelessWidget {
  final ContractModel contract;

  const AdminTenantContractTab({super.key, required this.contract});

  String _calculateRemainingTime(DateTime endDate) {
    final now = DateTime.now();
    final difference = endDate.difference(now);
    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months Bulan';
    } else {
      return '${difference.inDays} Hari';
    }
  }

  String _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'green';
      case 'cancelled':
        return 'orange';
      case 'ended':
        return 'red';
      default:
        return 'grey';
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Aktif';
      case 'ended':
        return 'Kadaluarsa';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return 'Tidak Diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Kontrak Aktif', [
            _buildInfoRow('Nomor Kontrak', contract.id.toString()),
            _buildInfoRow('Tanggal Mulai', formatDate(contract.startDate)),
            _buildInfoRow('Tanggal Berakhir', formatDate(contract.endDate)),
            _buildInfoRow('Kategori Sewa', contract.contractType),
            _buildInfoRow(
              'Status',
              _getStatusText(contract.status),
              valueColor: _getStatusColor(contract.status) == 'green'
                  ? const Color(0xFF059669)
                  : _getStatusColor(contract.status) == 'orange'
                  ? const Color(0xFFB45309)
                  : _getStatusColor(contract.status) == 'red'
                  ? const Color(0xFFDC2626)
                  : const Color(0xFF6B7280),
            ),
            _buildInfoRow(
              'Sisa Waktu',
              _calculateRemainingTime(contract.endDate),
              valueColor: const Color(0xFF059669),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
