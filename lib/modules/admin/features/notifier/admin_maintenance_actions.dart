import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminMaintenanceActions extends StateNotifier<AsyncValue<void>> {
  final MaintenanceService service;

  AdminMaintenanceActions(this.service) : super(const AsyncValue.data(null));

  Future<void> updateStatus(int ticketId, String status) async {
    state = const AsyncValue.loading();
    try {
      await service.updateStatus(ticketId, status);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
