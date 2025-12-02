import 'package:flutter/material.dart';

class UnitList extends StatelessWidget {
  final Map<String, dynamic> property;

  const UnitList({Key? key, required this.property}) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Terisi':
        return const Color(0xFF4CAF50);
      case 'Kosong':
        return const Color(0xFF9E9E9E);
      case 'Maintenance':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data untuk unit list
    final units = [
      {
        'number': 'A-101',
        'status': 'Terisi',
        'tenant': 'Ahmad Rizky',
        'startDate': '01 Jan 2023',
      },
      {
        'number': 'A-102',
        'status': 'Terisi',
        'tenant': 'Siti Nurhaliza',
        'startDate': '15 Feb 2023',
      },
      {
        'number': 'A-103',
        'status': 'Kosong',
        'tenant': null,
        'startDate': null,
      },
      {
        'number': 'A-104',
        'status': 'Terisi',
        'tenant': 'Budi Santoso',
        'startDate': '10 Mar 2023',
      },
      {
        'number': 'A-105',
        'status': 'Maintenance',
        'tenant': null,
        'startDate': null,
      },
      {
        'number': 'A-106',
        'status': 'Terisi',
        'tenant': 'Dewi Lestari',
        'startDate': '20 Apr 2023',
      },
      {
        'number': 'A-107',
        'status': 'Kosong',
        'tenant': null,
        'startDate': null,
      },
      {
        'number': 'A-108',
        'status': 'Terisi',
        'tenant': 'Eko Prasetyo',
        'startDate': '05 Mei 2023',
      },
    ];

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Icons.list_rounded,
                      color: Color(0xFFFF6B35),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Daftar Unit & Penghuni',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${units.length} unit',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFF6B35),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: units.length,
            separatorBuilder: (context, index) => const Divider(height: 20),
            itemBuilder: (context, index) {
              final unit = units[index];
              final status = unit['status'] as String;
              final tenant = unit['tenant'];
              final startDate = unit['startDate'];

              return Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withAlpha(26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        unit['number'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(status),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tenant ?? 'Unit $status',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: tenant != null
                                ? const Color(0xFF1A1A1A)
                                : const Color(0xFF757575),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          startDate != null
                              ? 'Mulai kontrak: $startDate'
                              : 'Tidak ada penghuni',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withAlpha(26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getStatusColor(status),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
