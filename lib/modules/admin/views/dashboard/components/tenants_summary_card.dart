import 'package:flutter/material.dart';

class TenantsSummaryCard extends StatelessWidget {
  const TenantsSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Navigate to Tenants page with filter
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigasi ke Tenants Management')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Penghuni Aktif',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.people_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTenantStat(
                      '47',
                      'Penghuni Aktif',
                      Icons.person_rounded,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  Expanded(
                    child: _buildTenantStat(
                      '6',
                      'Kontrak Akan Habis',
                      Icons.access_time_rounded,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  Expanded(
                    child: _buildTenantStat(
                      '3',
                      'Penghuni Baru',
                      Icons.fiber_new_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenantStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
        ),
      ],
    );
  }
}
