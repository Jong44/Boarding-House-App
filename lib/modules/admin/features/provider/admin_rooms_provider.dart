import 'package:boarding_house_app/modules/admin/features/notifier/admin_room_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/service/properties_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_type_service.dart';
import 'package:boarding_house_app/modules/admin/features/state/admin_room_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final adminRoomsProvider =
    StateNotifierProvider<AdminRoomNotifier, AdminRoomState>((ref) {
      final roomService = ref.watch(roomServiceProvider);
      final roomTypeService = ref.watch(roomTypeServiceProvider);
      final propertiesService = ref.watch(propertiesServiceProvider);

      return AdminRoomNotifier(
          roomTypeService: roomTypeService,
          roomService: roomService,
          propertiesService: propertiesService,
        )
        ..loadRooms()
        ..loadRoomTypes()
        ..loadProperties();
    });

final roomServiceProvider = Provider((ref) => RoomService());
final roomTypeServiceProvider = Provider((ref) => RoomTypeService());
final propertiesServiceProvider = Provider((ref) => PropertiesService());
