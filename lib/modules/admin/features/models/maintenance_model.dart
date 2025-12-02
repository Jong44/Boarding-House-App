class MaintenanceModel {
  final int? id;
  final int roomId;
  final int tenantId;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  MaintenanceModel({
    this.id,
    required this.roomId,
    required this.tenantId,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MaintenanceModel.fromMap(Map<String, dynamic> map) {
    return MaintenanceModel(
      id: map['id'] as int?,
      roomId: map['room_id'] as int,
      tenantId: map['tenant_id'] as int,
      description: map['description'] as String,
      status: map['status'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
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
