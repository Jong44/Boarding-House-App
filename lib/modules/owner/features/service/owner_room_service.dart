import 'package:boarding_house_app/modules/owner/features/models/owner_room_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerRoomService {
  final supabase = Supabase.instance.client;

  Future<OwnerRoomModel> getRoomOverview() async {
    final response = await supabase.from('rooms').select('*');

    final data = (response as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    final dashboardData = OwnerRoomModel(
      totalRooms: data.length,
      occupiedRooms: data.where((room) => room['status'] == "occupied").length,
      vacantRooms: data.where((room) => room['status'] == "available").length,
      maintenanceRooms: data
          .where((room) => room['status'] == "maintenance")
          .length,
    );

    return dashboardData;
  }
}
