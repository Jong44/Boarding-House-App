import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/create_tenant_request_model.dart';
import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_contract_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

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

  Future<void> refreshContracts() async {
    await loadContracts();
  }

  /// FILTER LOKAL – tidak panggil API
  void filterTenants(String query) {
    if (query.isEmpty) {
      state = state.copyWith(contractsFiltered: []);
      return;
    }

    final allContracts = state.contracts["contracts"] ?? [];

    final lower = query.toLowerCase();

    final filtered = allContracts.where((contract) {
      final t = contract.tenantDetails;
      final r = contract.roomDetails;

      // safe lower-case getter
      final name = (t.fullName ?? "").toLowerCase();
      final email = (t.email ?? "").toLowerCase();
      final phone = (t.phoneNumber ?? "").toLowerCase();
      final roomNumber = (r.id.toString()).toLowerCase();

      return name.contains(lower) ||
          email.contains(lower) ||
          phone.contains(lower) ||
          roomNumber.contains(lower);
    }).toList();

    state = state.copyWith(contractsFiltered: filtered);
  }
}
