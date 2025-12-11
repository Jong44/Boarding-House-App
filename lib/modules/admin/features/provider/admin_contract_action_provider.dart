import 'package:boarding_house_app/modules/admin/features/notifier/admin_contract_action.dart';
import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final adminTenantActionNotifier = Provider((ref) => ContractService());

final adminTenantActionNotifierProvider =
    StateNotifierProvider<AdminContractAction, AsyncValue<void>>(
      (ref) => AdminContractAction(ref.read(adminTenantActionNotifier)),
    );
