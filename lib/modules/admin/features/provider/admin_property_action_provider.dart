import 'package:boarding_house_app/modules/admin/features/notifier/admin_maintenance_actions.dart';
import 'package:boarding_house_app/modules/admin/features/notifier/admin_property_action_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/notifier/admin_room_action_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/service/maintenance_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/properties_service.dart';
import 'package:boarding_house_app/modules/admin/features/service/room_service.dart';
import 'package:boarding_house_app/modules/owner/features/service/property_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final AdminPropertyActionProvider = Provider((ref) => PropertiesService());

final AdminPropertyActionNotifierProvider =
    StateNotifierProvider<AdminPropertyActionNotifier, AsyncValue<void>>(
      (ref) =>
          AdminPropertyActionNotifier(ref.read(AdminPropertyActionProvider)),
    );
