import 'package:boarding_house_app/modules/penghuni/features/services/tenant_contract_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_maintance_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_user_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/state/tenant_dashboard_tenants.dart';
import 'package:flutter_riverpod/legacy.dart';

class TenantDashboardNotifier
    extends StateNotifier<TenantDashboardTenantsState> {
  final TenantContractService contractService;
  final TenantInvoiceService invoiceService;
  final TenantMaintanceService maintenanceService;
  final TenantUserService userService;

  TenantDashboardNotifier({
    required this.contractService,
    required this.invoiceService,
    required this.maintenanceService,
    required this.userService,
  }) : super(const TenantDashboardTenantsState());

  Future<void> loadContracts() async {
    state = state.copyWith(isLoadingContract: true);
    try {
      final result = await contractService.getActiveContract();
      state = state.copyWith(isLoadingContract: false, contract: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingContract: false,
        errorContract: e.toString(),
      );
    }
  }

  Future<void> loadMaintenance() async {
    state = state.copyWith(isLoadingMaintenance: true);

    try {
      final result = await maintenanceService.getNewestMaintenances();
      state = state.copyWith(isLoadingMaintenance: false, maintenance: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingMaintenance: false,
        errorMaintenance: e.toString(),
      );
    }
  }

  Future<void> loadInvoice() async {
    state = state.copyWith(isLoadingInvoice: true);
    try {
      final result = await invoiceService.getLatestInvoice();
      state = state.copyWith(isLoadingInvoice: false, invoice: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingInvoice: false,
        errorInvoice: e.toString(),
      );
    }
  }

  Future<void> loadUserProfile() async {
    state = state.copyWith(isLoadingProfile: true);
    try {
      final result = await userService.getUserProfile();
      state = state.copyWith(isLoadingProfile: false, userProfile: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingProfile: false,
        errorProfile: e.toString(),
      );
    }
  }

  Future<void> refreshAll() async {
    await Future.wait([
      loadContracts(),
      loadMaintenance(),
      loadInvoice(),
      loadUserProfile(),
    ]);
  }
}
