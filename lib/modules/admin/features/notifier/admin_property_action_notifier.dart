import 'package:boarding_house_app/models/properties_model.dart';
import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/modules/admin/features/service/properties_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminPropertyActionNotifier extends StateNotifier<AsyncValue<void>> {
  final PropertiesService service;

  AdminPropertyActionNotifier(this.service)
    : super(const AsyncValue.data(null));

  Future<void> createProperty(PropertiesModel property) async {
    state = const AsyncValue.loading();
    try {
      await service.createProperty(property);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print("Error creating room: $e");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProperty(PropertiesModel property, int id) async {
    state = const AsyncValue.loading();
    try {
      await service.updateProperty(property, id);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print("Error updating room: $e");
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteProperty(int propertyId) async {
    state = const AsyncValue.loading();
    try {
      await service.deleteProperty(propertyId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
