import 'package:boarding_house_app/modules/penghuni/features/models/tenant_create_ticket_request.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<Map<String, dynamic>> getMaintenanceOverview() async {
    final response = await supabase
        .from('maintenance_tickets')
        .select('*, rooms:room_id (property_id (owner_id))');

    final data = (response as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    final overviewData = {
      'pending': data.where((ticket) => ticket['status'] == "open").length,
      'inProgress': data
          .where((ticket) => ticket['status'] == "in_progress")
          .length,
      'tickets': data
          .where((ticket) => ticket['status'] == "open")
          .toList()
          .take(5)
          .toList(),
    };

    return overviewData;
  }
}
