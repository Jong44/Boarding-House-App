import 'package:boarding_house_app/modules/admin/features/models/maintenance_model.dart';
import 'package:boarding_house_app/modules/penghuni/features/models/tenant_create_ticket_request.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TenantMaintanceService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<List<MaintenanceModel>> getNewestMaintenances() async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('maintenance_tickets')
        .select('*, rooms(*) , users:tenant_id(*)')
        .eq('tenant_id', userId ?? "")
        .order('created_at', ascending: false)
        .limit(5);

    final data = (response as List)
        .map((e) => MaintenanceModel.fromMap(e as Map<String, dynamic>))
        .toList();

    return data;
  }

  Future<void> createMaintenanceTicket({
    required TenantCreateTicketRequest request,
  }) async {
    final user = await authService.getCurrentUser();

    await supabase.from('maintenance_tickets').insert({
      'room_id': request.roomId,
      'description': request.description,
      'status': 'open',
      'tenant_id': user!.id,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> deleteMaintenanceTicket(int ticketId) async {
    await supabase.from('maintenance_tickets').delete().eq('id', ticketId);
  }
}
