import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/payment_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/properties_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_type_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_dashboard_state.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_room_state.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminRoomNotifier extends StateNotifier<AdminRoomState> {
  final RoomService roomService;
  final RoomTypeService roomTypeService;
  final PropertiesService propertiesService;

  AdminRoomNotifier({
    required this.roomTypeService,
    required this.roomService,
    required this.propertiesService,
  }) : super(const AdminRoomState());

  Future<void> loadRooms() async {
    state = state.copyWith(isLoadingRoom: true);

    try {
      final result = await roomService.getAllRooms();
      state = state.copyWith(isLoadingRoom: false, rooms: result);
    } catch (e) {
      state = state.copyWith(isLoadingRoom: false, errorRoom: e.toString());
    }
  }

  Future<void> loadRoomTypes() async {
    state = state.copyWith(isLoadingRoom: true);

    try {
      final result = await roomTypeService.getAllRoomTypes();
      state = state.copyWith(isLoadingRoomType: false, roomTypes: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingRoomType: false,
        errorRoomType: e.toString(),
      );
    }
  }

  Future<void> loadProperties() async {
    state = state.copyWith(isLoadingProperty: true);

    try {
      final result = await propertiesService.getAllProperties();
      state = state.copyWith(isLoadingProperty: false, properties: result);
    } catch (e) {
      state = state.copyWith(
        isLoadingProperty: false,
        errorProperty: e.toString(),
      );
    }
  }

  Future<void> refreshAll() async {
    await Future.wait([loadProperties(), loadRooms(), loadRoomTypes()]);
  }
}
