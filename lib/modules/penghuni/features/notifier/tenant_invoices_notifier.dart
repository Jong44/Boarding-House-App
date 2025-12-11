import 'package:boarding_house_app/modules/penghuni/features/services/tenant_contract_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_maintance_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/state/tenant_dashboard_tenants.dart';
import 'package:boarding_house_app/modules/penghuni/features/state/tenant_invoices_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class TenantInvoicesNotifier extends StateNotifier<TenantInvoicesState> {
  final TenantInvoiceService invoiceService;

  TenantInvoicesNotifier({required this.invoiceService})
    : super(TenantInvoicesState());

  Future<void> loadInvoice() async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await invoiceService.getAllInvoices();
      state = state.copyWith(isLoading: false, invoices: result);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> refreshAll() async {
    await Future.wait([loadInvoice()]);
  }
}
