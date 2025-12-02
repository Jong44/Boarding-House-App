import 'package:boarding_house_app/modules/admin/features/models/dashboard_contracts_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/dashboard_room_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_dashboard_provider.dart';
import 'package:boarding_house_app/modules/admin/views/dashboard/components/maintenance_card.dart';
import 'package:boarding_house_app/modules/admin/views/dashboard/components/revenue_card.dart';
import 'package:boarding_house_app/modules/admin/views/dashboard/components/room_status_card.dart';
import 'package:boarding_house_app/modules/admin/views/dashboard/components/tenants_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardAdminPage extends ConsumerWidget {
  const DashboardAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider);

    if (state.isLoadingContracts ||
        state.isLoadingRooms ||
        state.isLoadingPayments) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorContracts != null) return Text(state.errorContracts!);
    if (state.errorRooms != null) return Text(state.errorRooms!);
    if (state.errorPayments != null) return Text(state.errorPayments!);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TenantsSummaryCard(
              data:
                  state.contracts ??
                  DashboardContractsModel(
                    totalContractsActive: 0,
                    totalContractsExpiringSoon: 0,
                    totalContractsNews: 0,
                  ),
            ),
            const SizedBox(height: 10),
            RoomStatusCard(
              data:
                  state.rooms ??
                  DashboardRoomModel(
                    totalRooms: 0,
                    vacantRooms: 0,
                    occupiedRooms: 0,
                    maintenanceRooms: 0,
                  ),
            ),
            const SizedBox(height: 10),
            RevenueCard(
              data: state.payments ?? {'totalIncome': 0, 'trendData': 0},
            ),
            const SizedBox(height: 10),
            MaintenanceCard(
              tickets:
                  state.maintenance ??
                  {'pending': 0, 'inProgress': 0, 'tickets': []},
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
