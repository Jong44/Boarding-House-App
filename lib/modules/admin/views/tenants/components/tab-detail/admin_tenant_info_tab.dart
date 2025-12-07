import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/utils/format_currency.dart';
import 'package:flutter/material.dart';

class AdminTenantInfoTab extends StatelessWidget {
  final ContractModel contract;
  const AdminTenantInfoTab({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard('Identitas Penyewa', [
            _buildInfoRow(
              'Nama Lengkap',
              contract.tenantDetails?.fullName ?? '',
            ),
            _buildInfoRow(
              'Nomor HP',
              contract.tenantDetails?.phoneNumber ?? '',
            ),
            _buildInfoRow('Email', contract.tenantDetails?.email ?? ''),
            _buildInfoRow('Tanggal Masuk', contract.startDate.toString()),
          ]),
          const SizedBox(height: 12),
          _buildInfoCard('Informasi Kamar', [
            _buildInfoRow(
              'Nomor Kamar',
              contract.roomDetails?.id.toString() ?? '',
            ),
            _buildInfoRow('Tipe Kamar', '3x4 meter'),
            _buildInfoRow(
              'Harga Sewa',
              formatCurrency(contract.price.toInt()) + '/bulan',
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
