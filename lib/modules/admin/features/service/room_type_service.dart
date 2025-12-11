import 'package:boarding_house_app/models/room_type_model.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomTypeService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<List<RoomTypeModel>> getAllRoomTypes() async {
    final response = await supabase.from('room_types').select();

    final data = (response as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return data.map((e) => RoomTypeModel.fromJson(e)).toList();
  }

  Future<void> createRoomType(RoomTypeModel roomType) async {
    final newData = {
      'name': roomType.name,
      'description': roomType.description,
      'property_id': roomType.propertyId,
    };
    await supabase.from('room_types').insert(newData);
  }

  Future<void> updateRoomType(int roomTypeId, RoomTypeModel roomType) async {
    final updatedData = {
      'name': roomType.name,
      'description': roomType.description,
      'property_id': roomType.propertyId,
    };
    await supabase.from('room_types').update(updatedData).eq('id', roomTypeId);
  }

  Future<void> deleteRoomType(int roomTypeId) async {
    await supabase.from('room_types').delete().eq('id', roomTypeId);
  }
}
