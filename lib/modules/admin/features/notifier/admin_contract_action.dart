import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminContractAction extends StateNotifier<AsyncValue<void>> {
  final ContractService service;

  AdminContractAction(this.service) : super(const AsyncValue.data(null));

  Future<void> createTenant(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      await service.createTenant(data);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error creating tenant: $e');
      state = AsyncValue.error(e, st);
    }
  }
}
