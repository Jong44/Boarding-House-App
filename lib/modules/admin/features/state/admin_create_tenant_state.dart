import 'package:boarding_house_app/models/properties_model.dart';
import 'package:boarding_house_app/models/room_model.dart';

class AdminCreateTenantState {
  final bool isLoading;
  final List<PropertiesModel> properties;
  final List<RoomModel> rooms;
  final String? error;

  const AdminCreateTenantState({
    this.isLoading = false,
    this.properties = const [],
    this.rooms = const [],
    this.error,
  });

  AdminCreateTenantState copyWith({
    bool? isLoading,
    List<PropertiesModel>? properties,
    List<RoomModel>? rooms,
    String? error,
  }) {
    return AdminCreateTenantState(
      isLoading: isLoading ?? this.isLoading,
      properties: properties ?? this.properties,
      rooms: rooms ?? this.rooms,
      error: error ?? this.error,
    );
  }
}
