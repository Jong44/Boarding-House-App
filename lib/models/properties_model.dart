import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/models/room_type_model.dart';

class PropertiesModel {
  final int? id;
  final String name;
  final String address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<RoomTypeModel>? roomTypes;
  final List<RoomModel>? rooms;

  PropertiesModel({
    this.id,
    required this.name,
    required this.address,
    this.createdAt,
    this.updatedAt,
    this.roomTypes,
    this.rooms,
  });

  factory PropertiesModel.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return PropertiesModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roomTypes: json['room_types'] != null
          ? (json['room_types'] as List)
                .map((e) => RoomTypeModel.fromJson(e))
                .toList()
          : null,
      rooms: json['rooms'] != null
          ? (json['rooms'] as List).map((e) => RoomModel.fromMap(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'room_types': roomTypes?.map((e) => e.toJson()).toList(),
      'rooms': rooms?.map((e) => e.toMap()).toList(),
    };
  }
}
