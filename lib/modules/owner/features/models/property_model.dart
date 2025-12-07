class PropertyModel {
  final int id;
  final String name;
  final String address;
  final int totalUnits;
  final int occupiedUnits;
  final double monthlyRevenue;

  PropertyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.totalUnits,
    required this.occupiedUnits,
    required this.monthlyRevenue,
  });

  int get occupancyRate =>
      totalUnits > 0 ? ((occupiedUnits / totalUnits) * 100).round() : 0;

  String get status {
    if (occupiedUnits == 0) return 'Unit Kosong';
    if (occupancyRate >= 80) return 'Normal';
    return 'Low Occupancy';
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      totalUnits: json['totalUnits'] ?? 0,
      occupiedUnits: json['occupiedUnits'] ?? 0,
      monthlyRevenue: (json['monthlyRevenue'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'totalUnits': totalUnits,
      'occupiedUnits': occupiedUnits,
      'monthlyRevenue': monthlyRevenue,
      'occupancyRate': occupancyRate,
      'status': status,
    };
  }
}
