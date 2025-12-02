import 'package:flutter/material.dart';

class ContractInfoCard extends StatelessWidget {
  final Map<String, dynamic> property;

  const ContractInfoCard({Key? key, required this.property}) : super(key: key);

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy contract data
    final contractData = {
      'tenant': 'Ir. Bambang Suryanto',
      'startDate': '01 Januari 2024',
      'endDate': '31 Desember 2024',
      'monthlyRent': 15000000,
      'renewalStatus': 'Akan diperpanjang',
      'phone': '+62 812-3456-7890',
      'email': 'bambang@example.com',
    };

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withAlpha(26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.description_rounded,
                  color: Color(0xFFFF6B35),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Informasi Kontrak',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            icon: Icons.person_rounded,
            label: 'Penyewa',
            value: contractData['tenant'] as String,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.phone_rounded,
            label: 'Telepon',
            value: contractData['phone'] as String,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.email_rounded,
            label: 'Email',
            value: contractData['email'] as String,
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mulai Kontrak',
                      style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      contractData['startDate'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Akhir Kontrak',
                      style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      contractData['endDate'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Harga Sewa / Bulan',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  'Rp ${_formatCurrency(contractData['monthlyRent'] as int)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withAlpha(26),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF4CAF50).withAlpha(77),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.refresh_rounded,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status Perpanjangan',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF757575),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contractData['renewalStatus'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFFF6B35), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
