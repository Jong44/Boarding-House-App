import 'package:boarding_house_app/modules/owner/features/models/owner_maintenance_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerMaintenanceService {
  final supabase = Supabase.instance.client;

  Future<OwnerMaintenanceModel> getMaintenanceOverview() async {
    try {
      final ticketsResponse = await supabase
          .from('maintenance_tickets')
          .select('status');

      final tickets = (ticketsResponse as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      int pendingTickets = tickets
          .where((ticket) => ticket['status'] == 'open')
          .length;
      int inProgressTickets = tickets
          .where((ticket) => ticket['status'] == 'in_progress')
          .length;

      double monthlyMaintenanceCost = 0;

      return OwnerMaintenanceModel(
        pendingTickets: pendingTickets,
        inProgressTickets: inProgressTickets,
        monthlyMaintenanceCost: monthlyMaintenanceCost,
      );
    } catch (e) {
      return OwnerMaintenanceModel(
        pendingTickets: 0,
        inProgressTickets: 0,
        monthlyMaintenanceCost: 0,
      );
    }
  }
}
