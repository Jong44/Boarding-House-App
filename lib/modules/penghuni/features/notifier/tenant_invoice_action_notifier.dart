import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TenantInvoiceActionNotifier extends StateNotifier<AsyncValue<void>> {
  final TenantInvoiceService service;

  TenantInvoiceActionNotifier(this.service)
    : super(const AsyncValue.data(null));

  Future<void> createPayment(
    int invoiceId,
    Map<String, dynamic> paymentData,
  ) async {
    state = const AsyncValue.loading();
    try {
      await service.createPayment(invoiceId, paymentData);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error creating tenant: $e');
      state = AsyncValue.error(e, st);
    }
  }
}
