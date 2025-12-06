import 'package:supabase_flutter/supabase_flutter.dart';

class MaintenanceModel {
  final int id;
  final String description;
  final String status;
  final String roomName;
  final DateTime createdAt;

  MaintenanceModel({
    required this.id,
    required this.description,
    required this.status,
    required this.roomName,
    required this.createdAt,
  });

  String get statusDisplay {
    switch (status) {
      case 'completed':
        return 'Selesai';
      case 'in_progress':
        return 'In Progress';
      case 'open':
        return 'Open';
      default:
        return status;
    }
  }
}

class MaintenanceHistoryService {
  final supabase = Supabase.instance.client;

  Future<List<MaintenanceModel>> getMaintenanceForProperty(
    dynamic propertyId,
  ) async {
    try {
      final int propId = propertyId is String
          ? int.parse(propertyId)
          : propertyId as int;

      final roomsResponse = await supabase
          .from('rooms')
          .select('id')
          .eq('property_id', propId);

      final roomIds = (roomsResponse as List).map((r) => r['id']).toList();

      if (roomIds.isEmpty) return [];

      final ticketsResponse = await supabase
          .from('maintenance_tickets')
          .select('id, description, status, created_at, rooms(description)')
          .inFilter('room_id', roomIds)
          .order('created_at', ascending: false);

      final tickets = (ticketsResponse as List).map((ticket) {
        final room = ticket['rooms'];
        final roomName = room != null ? room['description'] ?? 'Room' : 'Room';

        return MaintenanceModel(
          id: ticket['id'],
          description: ticket['description'] ?? 'No description',
          status: ticket['status'] ?? 'open',
          roomName: roomName,
          createdAt: DateTime.parse(ticket['created_at']),
        );
      }).toList();

      return tickets;
    } catch (e) {
      return [];
    }
  }
}
