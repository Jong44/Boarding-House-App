import 'package:boarding_house_app/modules/penghuni/features/notifier/tenant_invoices_notifier.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/state/tenant_invoices_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final tenantInvoicesProvider =
    StateNotifierProvider<TenantInvoicesNotifier, TenantInvoicesState>((ref) {
      final invoiceService = ref.watch(invoiceServiceProvider);

      return TenantInvoicesNotifier(invoiceService: invoiceService)
        ..loadInvoice();
    });

final invoiceServiceProvider = Provider((ref) => TenantInvoiceService());
