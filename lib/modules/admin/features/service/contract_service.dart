import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/properties_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/dashboard_contracts_model.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContractService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<DashboardContractsModel> getOverviewContract() async {
    final response = await supabase
        .from('contracts')
        .select(
          '*, rooms:room_id (*, properties:property_id (owner_id)), tenants:tenant_id (*), invoices(*, payments(*))',
        );

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

  Future<List<ContractModel>> searchContracts(String query) async {
    final response = await supabase
        .from('contracts')
        .select(
          '*, rooms:room_id (*, properties:property_id (owner_id)), tenants:tenant_id (*), invoices(*, payments(*))',
        )
        .ilike('tenants.full_name', '%$query%')
        .ilike('tenants.phone', '%$query%');

    final data = (response as List)
        .map((e) => ContractModel.fromMap(e as Map<String, dynamic>))
        .toList();

    return data;
  }

  Future<Map<String, dynamic>> getAllContracts() async {
    final response = await supabase
        .from('contracts')
        .select(
          '*, rooms:room_id (*, properties:property_id (owner_id)), tenants:tenant_id (*), invoices(*, payments(*))',
        );

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
                  DateTime.now().add(const Duration(days: 7)),
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

  Future<void> createInvoice(Map<String, dynamic> invoiceData) async {
    await supabase.from('invoices').insert(invoiceData);
  }

  Future<void> endedContract(int contractId) async {
    await supabase
        .from('contracts')
        .update({'status': 'ended'})
        .eq('id', contractId);
  }

  Future<bool> createTenant(Map<String, dynamic> request) async {
    try {
      final adminSession = supabase.auth.currentSession;

      final adminAccessToken = adminSession?.accessToken;
      final adminRefreshToken = adminSession?.refreshToken;

      if (adminSession == null) {
        throw Exception('Admin not authenticated');
      }

      final rawName = request['full_name'];

      final fullName = (rawName is String ? rawName : '')
          .trim()
          .replaceAll(RegExp(r'\s+'), '')
          .toLowerCase();

      final safeName = fullName.isNotEmpty ? fullName : 'user';

      final defaultPassword = '$safeName@123';
      final AuthResponse res = await supabase.auth.signUp(
        email: request['email'],
        password: defaultPassword,
      );

      final User? user = res.user;

      final userId = await supabase
          .from('users')
          .insert({
            'email': user?.email,
            'full_name': request['full_name'],
            'phone': request['phone_number'],
            'role': 'tenant',
          })
          .select()
          .single();

      await supabase.from('tenant_profile').insert({
        'user_id': userId['id'],
        'address': request['address'],
      });

      await supabase.from('contracts').insert({
        'tenant_id': userId['id'],
        'room_id': request['room_id'],
        'start_date': request['start_date'],
        'end_date': request['end_date'],
        'status': 'active',
        'price': request['price'],
        'contract_type': request['contract_type'] ?? 'monthly',
      });

      await supabase.auth.setSession(adminRefreshToken!);

      return true;
    } catch (e) {
      throw Exception('Failed to create tenant: $e');
    }
  }

  Future<List<PropertiesModel>> getAllProperties() async {
    final response = await supabase
        .from('properties')
        .select('*, rooms(*), room_types(*)');

    final data = (response as List)
        .map((e) => PropertiesModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return data;
  }
}
