class RoomModel {
  final int? id;
  final int? propertyId;
  final int? roomTypeId;
  final String? description;
  final String status;

  RoomModel({
    this.id,
    required this.propertyId,
    required this.roomTypeId,
    this.description = '',
    required this.status,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    print(map.toString());
    return RoomModel(
      id: map['id'] as int?,
      propertyId: map['property_id'] as int?,
      roomTypeId: map['room_type_id'] as int?,
      description: map['description'] as String?,
      status: map['status'] as String? ?? 'available',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'property_id': propertyId,
      'room_type_id': roomTypeId,
      'description': description,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'RoomModel{id: $id, propertyId: $propertyId, roomTypeId: $roomTypeId, description: $description, status: $status}';
  }
}
