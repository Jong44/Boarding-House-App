import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/dashboard_contracts_model.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContractService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<DashboardContractsModel> getOverviewContract() async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('contracts')
        .select()
        .eq('owner_id', userId ?? "");

    final data = (response as List)
        .map((e) => ContractModel.fromMap(e as Map<String, dynamic>))
        .toList();

    final dashboardData = DashboardContractsModel(
      totalContractsActive: data
          .where((contract) => contract.status == 'active')
          .length,
      totalContractsExpiringSoon: data
          .where(
            (contract) =>
                contract.endDate.isAfter(DateTime.now()) &&
                contract.endDate.isBefore(
                  DateTime.now().add(const Duration(days: 30)),
                ),
          )
          .length,
      totalContractsNews: data
          .where(
            (contract) =>
                contract.createdAt.isAfter(
                  DateTime.now().subtract(const Duration(days: 30)),
                ) &&
                contract.createdAt.isBefore(DateTime.now()),
          )
          .length,
    );

    return dashboardData;
  }

  Future<Map<String, dynamic>> getAllContracts() async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('contracts')
        .select(
          '*, rooms:room_id (*, properties:property_id (owner_id)), tenants:tenant_id (*)',
        )
        .eq('rooms.properties.owner_id', userId ?? "");

    print('ContractService.getAllContracts response: $response');

    final data = (response as List)
        .map((e) => ContractModel.fromMap(e as Map<String, dynamic>))
        .toList();

    final dataSummary = {
      'activeContracts': data
          .where((contract) => contract.status == 'active')
          .length,
      'expiringSoonContracts': data
          .where(
            (contract) =>
                contract.endDate.isAfter(DateTime.now()) &&
                contract.endDate.isBefore(
                  DateTime.now().add(const Duration(days: 30)),
                ),
          )
          .length,
      'overdueContracts': data
          .where((contract) => contract.endDate.isBefore(DateTime.now()))
          .length,
      'contracts': data,
    };

    return dataSummary;
  }
}
