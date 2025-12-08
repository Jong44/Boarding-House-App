import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/models/room_model.dart';

class MaintenanceModel {
  final int? id;
  final int roomId;
  final int tenantId;
  final String? description;
  final String? status;
  final AppUser? tenant;
  final RoomModel? room;
  final DateTime createdAt;
  final DateTime updatedAt;

  MaintenanceModel({
    this.id,
    required this.roomId,
    required this.tenantId,
    this.description,
    this.status,
    this.tenant,
    this.room,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MaintenanceModel.fromMap(Map<String, dynamic> map) {
    print(map.toString());
    return MaintenanceModel(
      id: map['id'] as int?,
      roomId: map['room_id'] as int,
      tenantId: map['tenant_id'] as int,
      description: map['description'] as String? ?? '',
      status: map['status'] as String? ?? '',
      createdAt: DateTime.parse(map['created_at'] as String? ?? ''),
      updatedAt: DateTime.parse(map['updated_at'] as String? ?? ''),
      tenant: map['users'] != null ? AppUser.fromMap(map['users']) : null,
      room: map['rooms'] != null ? RoomModel.fromMap(map['rooms']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'room_id': roomId,
      'tenant_id': tenantId,
      'description': description,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'MaintenanceModel{id: $id, roomId: $roomId, tenantId: $tenantId, description: $description, status: $status, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
