import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/models/room_type_model.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_type_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminRoomTypeActionNotifier extends StateNotifier<AsyncValue<void>> {
  final RoomTypeService service;

  AdminRoomTypeActionNotifier(this.service)
    : super(const AsyncValue.data(null));

  Future<void> createRoom(RoomTypeModel room) async {
    state = const AsyncValue.loading();
    try {
      await service.createRoomType(room);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print("Error creating room: $e");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateRoom(int roomId, RoomTypeModel room) async {
    state = const AsyncValue.loading();
    try {
      await service.updateRoomType(roomId, room);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteRoomType(int roomTypeId) async {
    state = const AsyncValue.loading();
    try {
      await service.deleteRoomType(roomTypeId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
