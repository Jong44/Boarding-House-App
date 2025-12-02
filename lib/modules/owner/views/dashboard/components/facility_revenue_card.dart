import 'package:flutter/material.dart';

class FacilityRevenueCard extends StatelessWidget {
  const FacilityRevenueCard({Key? key}) : super(key: key);

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final facilities = [
      {
        'name': 'Parkir Motor',
        'revenue': 8500000,
        'icon': Icons.two_wheeler_rounded,
      },
      {
        'name': 'Garasi Mobil',
        'revenue': 12000000,
        'icon': Icons.directions_car_rounded,
      },
      {
        'name': 'Laundry',
        'revenue': 5500000,
        'icon': Icons.local_laundry_service_rounded,
      },
      {
        'name': 'Air Galon',
        'revenue': 3200000,
        'icon': Icons.water_drop_rounded,
      },
    ];

    final totalRevenue = facilities.fold<int>(
      0,
      (sum, facility) => sum + (facility['revenue'] as int),
    );

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
                  Icons.category_rounded,
                  color: Color(0xFFFF6B35),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Revenue Fasilitas Tambahan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: facilities.length,
            separatorBuilder: (context, index) => const Divider(height: 20),
            itemBuilder: (context, index) {
              final facility = facilities[index];
              return Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withAlpha(26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      facility['icon'] as IconData,
                      color: const Color(0xFFFF6B35),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          facility['name'] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bulan Ini',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Rp ${_formatCurrency(facility['revenue'] as int)}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6B35),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
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
                Expanded(
                  child: const Text(
                    'Total Revenue Tambahan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Rp ${_formatCurrency(totalRevenue)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
