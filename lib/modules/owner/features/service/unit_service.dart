import 'package:supabase_flutter/supabase_flutter.dart';

class UnitModel {
  final int id;
  final String description;
  final String status;
  final String? tenantName;

  UnitModel({
    required this.id,
    required this.description,
    required this.status,
    this.tenantName,
  });
}

class UnitService {
  final supabase = Supabase.instance.client;

  Future<List<UnitModel>> getUnitsForProperty(dynamic propertyId) async {
    try {
      final int propId = propertyId is String
          ? int.parse(propertyId)
          : propertyId as int;

      final roomsResponse = await supabase
          .from('rooms')
          .select('id, description, status')
          .eq('property_id', propId);

      final rooms = (roomsResponse as List);
      final List<UnitModel> units = [];

      for (var room in rooms) {
        final roomId = room['id'];
        String? tenantName;

        final contractResponse = await supabase
            .from('contracts')
            .select('tenant_id')
            .eq('room_id', roomId)
            .eq('status', 'active')
            .maybeSingle();

        if (contractResponse != null) {
          final tenantId = contractResponse['tenant_id'];

          final userResponse = await supabase
              .from('users')
              .select('full_name')
              .eq('id', tenantId)
              .maybeSingle();

          if (userResponse != null) {
            tenantName = userResponse['full_name'];
          }
        }

        units.add(
          UnitModel(
            id: roomId,
            description: room['description'] ?? 'Room $roomId',
            status: room['status'] ?? 'available',
            tenantName: tenantName,
          ),
        );
      }

      return units;
    } catch (e) {
      return [];
    }
  }
}
