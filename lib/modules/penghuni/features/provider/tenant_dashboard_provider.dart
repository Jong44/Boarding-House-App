import 'package:boarding_house_app/modules/penghuni/features/notifier/tenant_dashboard_notifier.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_contract_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_maintance_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_user_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/state/tenant_dashboard_tenants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final tenantDashboardProvider =
    StateNotifierProvider<TenantDashboardNotifier, TenantDashboardTenantsState>(
      (ref) {
        final contractService = ref.watch(contractServiceProvider);
        final invoiceService = ref.watch(invoiceServiceProvider);
        final maintenanceService = ref.watch(maintenanceServiceProvider);
        final userService = ref.watch(userServiceProvider);

        return TenantDashboardNotifier(
            contractService: contractService,
            invoiceService: invoiceService,
            maintenanceService: maintenanceService,
            userService: userService,
          )
          ..loadContracts()
          ..loadMaintenance()
          ..loadInvoice()
          ..loadUserProfile();
      },
    );

final contractServiceProvider = Provider((ref) => TenantContractService());
final invoiceServiceProvider = Provider((ref) => TenantInvoiceService());
final maintenanceServiceProvider = Provider((ref) => TenantMaintanceService());
final userServiceProvider = Provider((ref) => TenantUserService());
