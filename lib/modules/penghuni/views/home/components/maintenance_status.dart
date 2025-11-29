import 'package:flutter/material.dart';

class MaintenanceStatus extends StatefulWidget {
  const MaintenanceStatus({super.key});

  @override
  State<MaintenanceStatus> createState() => _MaintenanceStatusState();
}

class _MaintenanceStatusState extends State<MaintenanceStatus> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMaintenanceCard(
          'Perbaikan AC',
          'In Progress',
          const Color(0xFFFF9800),
          Icons.ac_unit_outlined,
        ),
        const SizedBox(height: 12),
        _buildMaintenanceCard(
          'Keran Bocor',
          'Completed',
          const Color(0xFF4CAF50),
          Icons.water_drop_outlined,
        ),
      ],
    );
  }

  Widget _buildMaintenanceCard(
    String title,
    String status,
    Color statusColor,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: statusColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
