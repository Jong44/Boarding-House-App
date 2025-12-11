import 'package:boarding_house_app/modules/owner/features/models/owner_invoice_model.dart';
import 'package:boarding_house_app/modules/owner/features/models/owner_maintenance_model.dart';
import 'package:boarding_house_app/modules/owner/features/models/owner_occupancy_model.dart';
import 'package:boarding_house_app/modules/owner/features/models/owner_revenue_model.dart';
import 'package:boarding_house_app/modules/owner/features/models/owner_room_model.dart';
import 'package:boarding_house_app/modules/owner/features/models/revenue_chart_model.dart';

class OwnerDashboardState {
  final bool isLoadingRoom;
  final bool isLoadingRevenue;
  final bool isLoadingOccupancy;
  final bool isLoadingMaintenance;
  final bool isLoadingInvoice;
  final bool isLoadingRevenueChart;

  final OwnerRoomModel? roomData;
  final OwnerRevenueModel? revenueData;
  final OwnerOccupancyModel? occupancyData;
  final OwnerMaintenanceModel? maintenanceData;
  final OwnerInvoiceModel? invoiceData;
  final List<RevenueChartModel>? revenueChartData;

  final String? errorRoom;
  final String? errorRevenue;
  final String? errorOccupancy;
  final String? errorMaintenance;
  final String? errorInvoice;
  final String? errorRevenueChart;

  const OwnerDashboardState({
    this.isLoadingRoom = false,
    this.isLoadingRevenue = false,
    this.isLoadingOccupancy = false,
    this.isLoadingMaintenance = false,
    this.isLoadingInvoice = false,
    this.isLoadingRevenueChart = false,
    this.roomData,
    this.revenueData,
    this.occupancyData,
    this.maintenanceData,
    this.invoiceData,
    this.revenueChartData,
    this.errorRoom,
    this.errorRevenue,
    this.errorOccupancy,
    this.errorMaintenance,
    this.errorInvoice,
    this.errorRevenueChart,
  });

  OwnerDashboardState copyWith({
    bool? isLoadingRoom,
    bool? isLoadingRevenue,
    bool? isLoadingOccupancy,
    bool? isLoadingMaintenance,
    bool? isLoadingInvoice,
    bool? isLoadingRevenueChart,
    OwnerRoomModel? roomData,
    OwnerRevenueModel? revenueData,
    OwnerOccupancyModel? occupancyData,
    OwnerMaintenanceModel? maintenanceData,
    OwnerInvoiceModel? invoiceData,
    List<RevenueChartModel>? revenueChartData,
    String? errorRoom,
    String? errorRevenue,
    String? errorOccupancy,
    String? errorMaintenance,
    String? errorInvoice,
    String? errorRevenueChart,
  }) {
    return OwnerDashboardState(
      isLoadingRoom: isLoadingRoom ?? this.isLoadingRoom,
      isLoadingRevenue: isLoadingRevenue ?? this.isLoadingRevenue,
      isLoadingOccupancy: isLoadingOccupancy ?? this.isLoadingOccupancy,
      isLoadingMaintenance: isLoadingMaintenance ?? this.isLoadingMaintenance,
      isLoadingInvoice: isLoadingInvoice ?? this.isLoadingInvoice,
      isLoadingRevenueChart:
          isLoadingRevenueChart ?? this.isLoadingRevenueChart,
      roomData: roomData ?? this.roomData,
      revenueData: revenueData ?? this.revenueData,
      occupancyData: occupancyData ?? this.occupancyData,
      maintenanceData: maintenanceData ?? this.maintenanceData,
      invoiceData: invoiceData ?? this.invoiceData,
      revenueChartData: revenueChartData ?? this.revenueChartData,
      errorRoom: errorRoom ?? this.errorRoom,
      errorRevenue: errorRevenue ?? this.errorRevenue,
      errorOccupancy: errorOccupancy ?? this.errorOccupancy,
      errorMaintenance: errorMaintenance ?? this.errorMaintenance,
      errorInvoice: errorInvoice ?? this.errorInvoice,
      errorRevenueChart: errorRevenueChart ?? this.errorRevenueChart,
    );
  }
}
