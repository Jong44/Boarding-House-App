import 'package:flutter/material.dart';

class RoomStatusCard extends StatelessWidget {
  const RoomStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigasi ke Room Management')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status Kamar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Total: 43',
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildRoomStatusItem(
                      '12',
                      'Tersedia',
                      Icons.home_rounded,
                      const Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildRoomStatusItem(
                      '28',
                      'Terisi',
                      Icons.meeting_room_rounded,
                      const Color(0xFFFF6B35),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildRoomStatusItem(
                      '3',
                      'Maintenance',
                      Icons.build_rounded,
                      const Color(0xFFFFC107),
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

  Widget _buildRoomStatusItem(
    String count,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 12)),
        ],
      ),
    );
  }
}
