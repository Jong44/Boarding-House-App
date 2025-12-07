class OwnerRoomModel {
  final int totalRooms;
  final int occupiedRooms;
  final int vacantRooms;
  final int maintenanceRooms;

  OwnerRoomModel({
    required this.totalRooms,
    required this.occupiedRooms,
    required this.vacantRooms,
    this.maintenanceRooms = 0,
  });

  factory OwnerRoomModel.fromJson(Map<String, dynamic> json) {
    return OwnerRoomModel(
      totalRooms: json['total_rooms'] ?? 0,
      occupiedRooms: json['occupied_rooms'] ?? 0,
      vacantRooms: json['vacant_rooms'] ?? 0,
      maintenanceRooms: json['maintenance_rooms'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_rooms': totalRooms,
      'occupied_rooms': occupiedRooms,
      'vacant_rooms': vacantRooms,
      'maintenance_rooms': maintenanceRooms,
    };
  }

  @override
  String toString() {
    return 'OwnerRoomModel{totalRooms: $totalRooms, occupiedRooms: $occupiedRooms, vacantRooms: $vacantRooms, maintenanceRooms: $maintenanceRooms}';
  }
}
