import 'package:boarding_house_app/modules/admin/features/notifier/admin_maintenance_actions.dart';
import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final adminMaintenanceProvider = Provider((ref) => MaintenanceService());

final AdminMaintenanceActionNotifierProvider =
    StateNotifierProvider<AdminMaintenanceActions, AsyncValue<void>>(
      (ref) => AdminMaintenanceActions(ref.read(adminMaintenanceProvider)),
    );
