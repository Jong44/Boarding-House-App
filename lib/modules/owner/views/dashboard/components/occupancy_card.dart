import 'package:flutter/material.dart';

class OccupancyCard extends StatelessWidget {
  const OccupancyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const occupiedRooms = 86;
    const totalRooms = 102;
    final occupancyRate = (occupiedRooms / totalRooms * 100).toInt();

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
                      Icons.meeting_room_rounded,
                      color: Color(0xFFFF6B35),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Occupancy Rate',
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
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withAlpha(26),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$occupancyRate%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: occupancyRate / 100,
              minHeight: 12,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF4CAF50),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$occupiedRooms dari $totalRooms unit terisi',
                style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
              Text(
                '${totalRooms - occupiedRooms} kosong',
                style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
