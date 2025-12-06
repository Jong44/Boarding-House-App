import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_contract_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminTenantsNotifier extends StateNotifier<AdminContractState> {
  final ContractService contractService;

  AdminTenantsNotifier({required this.contractService})
    : super(const AdminContractState());

  Future<void> loadContracts() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await contractService.getAllContracts();
      state = state.copyWith(isLoading: false, contracts: result);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
