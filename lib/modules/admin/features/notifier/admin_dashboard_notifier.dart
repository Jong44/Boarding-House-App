import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/payment_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_dashboard_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class DashboardDataNotifier extends StateNotifier<AdminDashboardState> {
  final ContractService contractService;
  final RoomService roomService;
  final PaymentService paymentService;
  final MaintenanceService maintenanceService;

  DashboardDataNotifier({
    required this.contractService,
    required this.roomService,
    required this.paymentService,
    required this.maintenanceService,
  }) : super(const AdminDashboardState());

  Future<void> loadContracts() async {
    state = state.copyWith(isLoadingContracts: true);

    try {
      final result = await contractService.getOverviewContract();
      state = state.copyWith(isLoadingContracts: false, contracts: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingContracts: false,
        errorContracts: e.toString(),
      );
    }
  }

  Future<void> loadRooms() async {
    state = state.copyWith(isLoadingRooms: true);

    try {
      final result = await roomService.getRoomOverview();
      state = state.copyWith(isLoadingRooms: false, rooms: result);
    } catch (e) {
      state = state.copyWith(isLoadingRooms: false, errorRooms: e.toString());
    }
  }

  Future<void> loadPayments() async {
    state = state.copyWith(isLoadingPayments: true);

    try {
      final result = await paymentService.getPaymentSummary();
      state = state.copyWith(isLoadingPayments: false, payments: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingPayments: false,
        errorPayments: e.toString(),
      );
    }
  }

  Future<void> loadMaintenance() async {
    state = state.copyWith(isLoadingMaintenance: true);

    try {
      final result = await maintenanceService.getMaintenanceOverview();
      state = state.copyWith(isLoadingMaintenance: false, maintenance: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingMaintenance: false,
        errorMaintenance: e.toString(),
      );
    }
  }
}
