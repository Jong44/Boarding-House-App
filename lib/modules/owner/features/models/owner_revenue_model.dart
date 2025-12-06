class OwnerRevenueModel {
  final double monthlyRevenue;
  final double yearlyRevenue;

  OwnerRevenueModel({
    required this.monthlyRevenue,
    required this.yearlyRevenue,
  });

  factory OwnerRevenueModel.fromJson(Map<String, dynamic> json) {
    return OwnerRevenueModel(
      monthlyRevenue: (json['monthly_revenue'] ?? 0).toDouble(),
      yearlyRevenue: (json['yearly_revenue'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'monthly_revenue': monthlyRevenue, 'yearly_revenue': yearlyRevenue};
  }

  @override
  String toString() {
    return 'OwnerRevenueModel{monthlyRevenue: $monthlyRevenue, yearlyRevenue: $yearlyRevenue}';
  }
}
