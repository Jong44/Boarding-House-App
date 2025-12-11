class RoomTypeModel {
  final int? id;
  final String name;
  final String description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? propertyId;

  RoomTypeModel({
    this.id,
    required this.name,
    required this.description,
    this.createdAt,
    this.updatedAt,
    this.propertyId,
  });

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) {
    return RoomTypeModel(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      propertyId: json['property_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'property_id': propertyId,
    };
  }
}
