import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TenantContractService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<ContractModel?> getActiveContract() async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('contracts')
        .select(
          '*, rooms:room_id (*, properties:property_id (*)), tenants:tenant_id (*), invoices(*, payments(*))',
        )
        .eq('tenant_id', userId ?? "")
        .eq('status', 'active')
        .maybeSingle();

    if (response == null) {
      return null;
    }

    final contract = ContractModel.fromMap(response as Map<String, dynamic>);

    return contract;
  }
}
