import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/properties_model.dart';
import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/models/room_type_model.dart';

class AdminRoomState {
  final bool isLoadingProperty;
  final bool isLoadingRoom;
  final bool isLoadingRoomType;

  final List<PropertiesModel> properties;
  final List<RoomModel> rooms;
  final List<RoomTypeModel> roomTypes;

  final List<PropertiesModel> propertiesFiltered;
  final List<RoomModel> roomsFiltered;
  final List<RoomTypeModel> roomTypesFiltered;

  final String? errorProperty;
  final String? errorRoom;
  final String? errorRoomType;

  const AdminRoomState({
    this.isLoadingProperty = false,
    this.isLoadingRoom = false,
    this.isLoadingRoomType = false,

    this.properties = const [],
    this.rooms = const [],
    this.roomTypes = const [],

    this.propertiesFiltered = const [],
    this.roomsFiltered = const [],
    this.roomTypesFiltered = const [],

    this.errorProperty,
    this.errorRoom,
    this.errorRoomType,
  });

  AdminRoomState copyWith({
    bool? isLoadingProperty,
    bool? isLoadingRoom,
    bool? isLoadingRoomType,

    List<PropertiesModel>? properties,
    List<RoomModel>? rooms,
    List<RoomTypeModel>? roomTypes,

    List<PropertiesModel>? propertiesFiltered,
    List<RoomModel>? roomsFiltered,
    List<RoomTypeModel>? roomTypesFiltered,

    String? errorProperty,
    String? errorRoom,
    String? errorRoomType,
  }) {
    return AdminRoomState(
      isLoadingProperty: isLoadingProperty ?? this.isLoadingProperty,
      isLoadingRoom: isLoadingRoom ?? this.isLoadingRoom,
      isLoadingRoomType: isLoadingRoomType ?? this.isLoadingRoomType,
      properties: properties ?? this.properties,
      rooms: rooms ?? this.rooms,
      roomTypes: roomTypes ?? this.roomTypes,
      propertiesFiltered: propertiesFiltered ?? this.propertiesFiltered,
      roomsFiltered: roomsFiltered ?? this.roomsFiltered,
      roomTypesFiltered: roomTypesFiltered ?? this.roomTypesFiltered,
      errorProperty: errorProperty ?? this.errorProperty,
      errorRoom: errorRoom ?? this.errorRoom,
      errorRoomType: errorRoomType ?? this.errorRoomType,
    );
  }
}
