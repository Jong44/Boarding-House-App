import 'package:boarding_house_app/modules/owner/features/provider/owner_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomStatusCard extends ConsumerWidget {
  const RoomStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(ownerDashboardProvider);
    final isLoading = dashboardState.isLoadingRoom;
    final roomData = dashboardState.roomData;
    final error = dashboardState.errorRoom;

    final occupiedRooms = roomData?.occupiedRooms ?? 0;
    final vacantRooms = roomData?.vacantRooms ?? 0;
    final maintenanceRooms = roomData?.maintenanceRooms ?? 0;

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
                  Icons.door_front_door_rounded,
                  color: Color(0xFFFF6B35),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Status Kamar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            )
          else if (error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Gagal memuat data',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 320) {
                  return Column(
                    children: [
                      Expanded(
                        child: _buildStatusItem(
                          icon: Icons.check_circle_rounded,
                          label: 'Terisi',
                          count: occupiedRooms,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _buildStatusItem(
                          icon: Icons.radio_button_unchecked,
                          label: 'Kosong',
                          count: vacantRooms,
                          color: const Color(0xFF9E9E9E),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _buildStatusItem(
                          icon: Icons.build_circle_rounded,
                          label: 'Maintenance',
                          count: maintenanceRooms,
                          color: const Color(0xFFFF9800),
                        ),
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: _buildStatusItem(
                        icon: Icons.check_circle_rounded,
                        label: 'Terisi',
                        count: occupiedRooms,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatusItem(
                        icon: Icons.radio_button_unchecked,
                        label: 'Kosong',
                        count: vacantRooms,
                        color: const Color(0xFF9E9E9E),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _buildStatusItem(
                      icon: Icons.build_circle_rounded,
                      label: 'Maintenance',
                      count: maintenanceRooms,
                      color: const Color(0xFFFF9800),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
