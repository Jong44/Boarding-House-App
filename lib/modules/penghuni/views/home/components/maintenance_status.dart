import 'package:boarding_house_app/modules/admin/features/models/maintenance_model.dart';
import 'package:flutter/material.dart';

class MaintenanceStatus extends StatefulWidget {
  final List<MaintenanceModel> maintenances;
  const MaintenanceStatus({super.key, required this.maintenances});

  @override
  State<MaintenanceStatus> createState() =>
      _MaintenanceStatusState(maintenances: maintenances);
}

class _MaintenanceStatusState extends State<MaintenanceStatus> {
  final List<MaintenanceModel> maintenances;
  _MaintenanceStatusState({required this.maintenances});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...maintenances.map((maintenance) {
          Color statusColor;
          IconData icon;

          switch (maintenance.status.toLowerCase()) {
            case 'pending':
              statusColor = Colors.orange;
              icon = Icons.hourglass_empty;
              break;
            case 'in_progress':
              statusColor = Colors.blue;
              icon = Icons.build;
              break;
            case 'completed':
              statusColor = Colors.green;
              icon = Icons.check_circle;
              break;
            case 'rejected':
              statusColor = Colors.red;
              icon = Icons.cancel;
              break;
            default:
              statusColor = Colors.grey;
              icon = Icons.help_outline;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildMaintenanceCard(
              maintenance.description,
              maintenance.status.replaceAll('_', ' ').toUpperCase(),
              statusColor,
              icon,
            ),
          );
        }).toList(),
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
