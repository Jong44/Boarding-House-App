import 'package:boarding_house_app/modules/owner/features/models/owner_occupancy_model.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_invoice_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_maintenance_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_revenue_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_room_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/revenue_chart_service.dart';
import 'package:boarding_house_app/modules/owner/features/state/owner_dashboard_state.dart';
import 'package:state_notifier/state_notifier.dart';

class OwnerDashboardNotifier extends StateNotifier<OwnerDashboardState> {
  final OwnerRoomService roomService;
  final OwnerRevenueService revenueService;
  final OwnerMaintenanceService maintenanceService;
  final OwnerInvoiceService invoiceService;
  final RevenueChartService revenueChartService;

  OwnerDashboardNotifier({
    required this.roomService,
    required this.revenueService,
    required this.maintenanceService,
    required this.invoiceService,
    required this.revenueChartService,
  }) : super(const OwnerDashboardState());

  Future<void> loadRoomData() async {
    state = state.copyWith(isLoadingRoom: true);

    try {
      final result = await roomService.getRoomOverview();
      state = state.copyWith(isLoadingRoom: false, roomData: result);
    } catch (e) {
      state = state.copyWith(isLoadingRoom: false, errorRoom: e.toString());
    }
  }

  Future<void> loadRevenueData() async {
    state = state.copyWith(isLoadingRevenue: true);

    try {
      final result = await revenueService.getRevenueSummary();
      state = state.copyWith(isLoadingRevenue: false, revenueData: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingRevenue: false,
        errorRevenue: e.toString(),
      );
    }
  }

  Future<void> loadOccupancyData() async {
    state = state.copyWith(isLoadingOccupancy: true);

    try {
      final roomResult = await roomService.getRoomOverview();
      final occupancyData = OwnerOccupancyModel(
        occupiedRooms: roomResult.occupiedRooms,
        totalRooms: roomResult.totalRooms,
      );

      state = state.copyWith(
        isLoadingOccupancy: false,
        occupancyData: occupancyData,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingOccupancy: false,
        errorOccupancy: e.toString(),
      );
    }
  }

  Future<void> loadMaintenanceData() async {
    state = state.copyWith(isLoadingMaintenance: true);

    try {
      final result = await maintenanceService.getMaintenanceOverview();
      state = state.copyWith(
        isLoadingMaintenance: false,
        maintenanceData: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMaintenance: false,
        errorMaintenance: e.toString(),
      );
    }
  }

  Future<void> loadInvoiceData() async {
    state = state.copyWith(isLoadingInvoice: true);

    try {
      final result = await invoiceService.getOverdueInvoices();
      state = state.copyWith(isLoadingInvoice: false, invoiceData: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingInvoice: false,
        errorInvoice: e.toString(),
      );
    }
  }

  Future<void> loadRevenueChartData() async {
    state = state.copyWith(isLoadingRevenueChart: true);

    try {
      final result = await revenueChartService.getMonthlyRevenue(months: 12);
      state = state.copyWith(
        isLoadingRevenueChart: false,
        revenueChartData: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingRevenueChart: false,
        errorRevenueChart: e.toString(),
      );
    }
  }

  Future<void> loadAllData() async {
    await Future.wait([
      loadRoomData(),
      loadRevenueData(),
      loadMaintenanceData(),
      loadInvoiceData(),
      loadRevenueChartData(),
    ]);
  }
}
