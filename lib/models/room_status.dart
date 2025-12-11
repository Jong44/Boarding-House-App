class DashboardRoomModel {
  final int? totalRooms;
  final int? occupiedRooms;
  final int? vacantRooms;
  final int? maintenanceRooms;

  DashboardRoomModel({
    this.totalRooms,
    this.occupiedRooms,
    this.vacantRooms,
    this.maintenanceRooms,
  });

  factory DashboardRoomModel.fromJson(Map<String, dynamic> json) {
    return DashboardRoomModel(
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
    return 'DashboardRoomModel{totalRooms: $totalRooms, occupiedRooms: $occupiedRooms, vacantRooms: $vacantRooms, maintenanceRooms: $maintenanceRooms}';
  }
}
