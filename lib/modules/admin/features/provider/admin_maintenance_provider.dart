import 'package:boarding_house_app/modules/admin/features/notifier/admin_maintenance_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_maintenance_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final adminMaintenanceNotifierProvider =
    StateNotifierProvider<AdminMaintenanceNotifier, AdminMaintenanceState>((
      ref,
    ) {
      final maintenanceService = ref.watch(maintenanceServiceProvider);

      return AdminMaintenanceNotifier(maintenanceService: maintenanceService)
        ..loadMaintenances();
    });

final maintenanceServiceProvider = Provider((ref) => MaintenanceService());
