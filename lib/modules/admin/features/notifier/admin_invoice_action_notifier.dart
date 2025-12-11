import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminInvoiceActionNotifier extends StateNotifier<AsyncValue<void>> {
  final ContractService service;

  AdminInvoiceActionNotifier(this.service) : super(const AsyncValue.data(null));

  Future<void> createInvoice(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await service.createInvoice(data);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> endedContract(int contractId) async {
    state = const AsyncValue.loading();
    try {
      await service.endedContract(contractId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
