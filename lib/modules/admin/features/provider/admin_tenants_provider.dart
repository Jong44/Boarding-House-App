import 'package:boarding_house_app/modules/admin/features/notifier/admin_tenants_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_contract_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final adminTenantsProvider =
    StateNotifierProvider<AdminTenantsNotifier, AdminContractState>((ref) {
      final contractService = ref.watch(contractServiceProvider);

      return AdminTenantsNotifier(contractService: contractService)
        ..loadContracts();
    });

final contractServiceProvider = Provider((ref) => ContractService());
