import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/dashboard_room_model.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<DashboardRoomModel> getRoomOverview() async {
    final response = await supabase
        .from('rooms')
        .select('*, properties:property_id (owner_id)');

    final data = (response as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    final dashboardData = DashboardRoomModel(
      totalRooms: data.length,
      occupiedRooms: data.where((room) => room['status'] == "occupied").length,
      vacantRooms: data.where((room) => room['status'] == "available").length,
      maintenanceRooms: data
          .where((room) => room['status'] == "maintenance")
          .length,
    );

    return dashboardData;
  }

  Future<List<RoomModel>> getAllRooms() async {
    final response = await supabase.from('rooms').select();

    final data = (response as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return data.map((e) => RoomModel.fromMap(e)).toList();
  }

  Future<void> createRoom(RoomModel room) async {
    final user = authService.getCurrentUser();
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final roomData = {
      'property_id': room.propertyId,
      'room_type_id': room.roomTypeId,
      'status': room.status,
      'description': room.description,
    };

    final response = await supabase.from('rooms').insert(roomData);

    if (response.error != null) {
      throw Exception('Failed to create room: ${response.error!.message}');
    }
  }

  Future<void> updateRoom(int roomId, RoomModel room) async {
    final updatedData = {
      'property_id': room.propertyId,
      'room_type_id': room.roomTypeId,
      'status': room.status,
      'description': room.description,
    };

    final response = await supabase
        .from('rooms')
        .update(updatedData)
        .eq('id', roomId);

    if (response.error != null) {
      throw Exception('Failed to update room: ${response.error!.message}');
    }
  }

  Future<void> deleteRoom(int roomId) async {
    final response = await supabase.from('rooms').delete().eq('id', roomId);

    if (response.error != null) {
      throw Exception('Failed to delete room: ${response.error!.message}');
    }
  }
}
