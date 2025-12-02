import 'package:flutter/material.dart';

class PropertyStatsCard extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyStatsCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalUnits = property['totalUnits'] as int;
    final occupiedUnits = property['occupiedUnits'] as int;
    final vacantUnits = totalUnits - occupiedUnits;
    final maintenanceUnits = 2; // Dummy data

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
                  Icons.analytics_rounded,
                  color: Color(0xFFFF6B35),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Statistik Properti',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Total Unit',
                  value: '$totalUnits',
                  icon: Icons.meeting_room_rounded,
                  color: const Color(0xFFFF6B35),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  label: 'Terisi',
                  value: '$occupiedUnits',
                  icon: Icons.check_circle_rounded,
                  color: const Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  label: 'Kosong',
                  value: '$vacantUnits',
                  icon: Icons.radio_button_unchecked,
                  color: const Color(0xFF9E9E9E),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  label: 'Maintenance',
                  value: '$maintenanceUnits',
                  icon: Icons.build_circle_rounded,
                  color: const Color(0xFFFF9800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
