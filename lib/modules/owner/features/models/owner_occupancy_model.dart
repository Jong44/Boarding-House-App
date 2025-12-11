class OwnerOccupancyModel {
  final int occupiedRooms;
  final int totalRooms;

  OwnerOccupancyModel({required this.occupiedRooms, required this.totalRooms});

  int get occupancyRate {
    if (totalRooms == 0) return 0;
    return (occupiedRooms / totalRooms * 100).toInt();
  }

  factory OwnerOccupancyModel.fromJson(Map<String, dynamic> json) {
    return OwnerOccupancyModel(
      occupiedRooms: json['occupied_rooms'] ?? 0,
      totalRooms: json['total_rooms'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'occupied_rooms': occupiedRooms,
      'total_rooms': totalRooms,
      'occupancy_rate': occupancyRate,
    };
  }

  @override
  String toString() {
    return 'OwnerOccupancyModel{occupiedRooms: $occupiedRooms, totalRooms: $totalRooms, occupancyRate: $occupancyRate%}';
  }
}
