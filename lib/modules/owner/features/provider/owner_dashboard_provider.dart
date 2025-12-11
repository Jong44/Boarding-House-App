import 'package:boarding_house_app/modules/owner/features/notifier/owner_dashboard_notifier.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_invoice_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_maintenance_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_revenue_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/owner_room_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/revenue_chart_service.dart';
import 'package:boarding_house_app/modules/owner/features/state/owner_dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final ownerDashboardProvider =
    StateNotifierProvider<OwnerDashboardNotifier, OwnerDashboardState>((ref) {
      final roomService = ref.watch(ownerRoomServiceProvider);
      final revenueService = ref.watch(ownerRevenueServiceProvider);
      final maintenanceService = ref.watch(ownerMaintenanceServiceProvider);
      final invoiceService = ref.watch(ownerInvoiceServiceProvider);
      final revenueChartService = ref.watch(revenueChartServiceProvider);

      return OwnerDashboardNotifier(
        roomService: roomService,
        revenueService: revenueService,
        maintenanceService: maintenanceService,
        invoiceService: invoiceService,
        revenueChartService: revenueChartService,
      )..loadAllData();
    });

final ownerRoomServiceProvider = Provider((ref) => OwnerRoomService());
final ownerRevenueServiceProvider = Provider((ref) => OwnerRevenueService());
final ownerMaintenanceServiceProvider = Provider(
  (ref) => OwnerMaintenanceService(),
);
final ownerInvoiceServiceProvider = Provider((ref) => OwnerInvoiceService());
final revenueChartServiceProvider = Provider((ref) => RevenueChartService());
