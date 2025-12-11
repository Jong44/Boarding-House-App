import 'package:boarding_house_app/modules/admin/features/notifier/admin_room_type_action_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_type_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final AdminRoomTypeProvider = Provider((ref) => RoomTypeService());

final AdminRoomTypeActionNotifierProvider =
    StateNotifierProvider<AdminRoomTypeActionNotifier, AsyncValue<void>>(
      (ref) => AdminRoomTypeActionNotifier(ref.read(AdminRoomTypeProvider)),
    );
