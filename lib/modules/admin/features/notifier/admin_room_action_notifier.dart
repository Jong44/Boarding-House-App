import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminRoomActionNotifier extends StateNotifier<AsyncValue<void>> {
  final RoomService service;

  AdminRoomActionNotifier(this.service) : super(const AsyncValue.data(null));

  Future<void> createRoom(RoomModel room) async {
    state = const AsyncValue.loading();
    try {
      await service.createRoom(room);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print("Error creating room: $e");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateRoom(int roomId, RoomModel room) async {
    state = const AsyncValue.loading();
    try {
      await service.updateRoom(roomId, room);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteRoom(int roomId) async {
    state = const AsyncValue.loading();
    try {
      await service.deleteRoom(roomId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
