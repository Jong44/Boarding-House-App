import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_maintenance_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminMaintenanceNotifier extends StateNotifier<AdminMaintenanceState> {
  final MaintenanceService maintenanceService;

  AdminMaintenanceNotifier({required this.maintenanceService})
    : super(const AdminMaintenanceState());
  Future<void> loadMaintenances() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await maintenanceService.getAllMaintenances();
      state = state.copyWith(
        isLoading: false,
        maintenances: result,
        maintenancesFiltered: [],
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refreshMaintenances() async {
    await loadMaintenances();
  }

  void filterTenants(String query) {
    if (query.isEmpty) {
      state = state.copyWith(maintenancesFiltered: []);
      return;
    }

    final allMaintenances = state.maintenances;

    final lower = query.toLowerCase();

    final filtered = allMaintenances.where((maintenance) {
      final descr = maintenance.description!.toLowerCase();

      return descr.contains(lower);
    }).toList();

    state = state.copyWith(maintenancesFiltered: filtered);
  }
}
