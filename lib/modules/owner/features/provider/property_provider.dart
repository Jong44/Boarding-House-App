import 'package:boarding_house_app/modules/owner/features/notifier/property_notifier.dart';
import 'package:boarding_house_app/modules/owner/features/service/property_service.dart';
import 'package:boarding_house_app/modules/owner/features/state/property_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final propertyServiceProvider = Provider((ref) => PropertyService());

final propertyProvider = StateNotifierProvider<PropertyNotifier, PropertyState>(
  (ref) {
    final service = ref.watch(propertyServiceProvider);
    return PropertyNotifier(propertyService: service)..loadProperties();
  },
);
