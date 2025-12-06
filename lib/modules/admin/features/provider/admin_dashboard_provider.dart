import 'package:boarding_house_app/modules/admin/features/notifier/admin_dashboard_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/payment_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardDataNotifier, AdminDashboardState>((ref) {
      final contractService = ref.watch(contractServiceProvider);
      final roomService = ref.watch(roomServiceProvider);
      final paymentService = ref.watch(paymentServiceProvider);
      final maintenanceService = ref.watch(maintenanceServiceProvider);

      return DashboardDataNotifier(
          contractService: contractService,
          roomService: roomService,
          paymentService: paymentService,
          maintenanceService: maintenanceService,
        )
        ..loadContracts() // auto fetch on init
        ..loadRooms() // auto fetch on init
        ..loadPayments() // auto fetch on init
        ..loadMaintenance(); // auto fetch on init
    });

final contractServiceProvider = Provider((ref) => ContractService());
final roomServiceProvider = Provider((ref) => RoomService());
final paymentServiceProvider = Provider((ref) => PaymentService());
final maintenanceServiceProvider = Provider((ref) => MaintenanceService());
