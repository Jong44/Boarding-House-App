class RevenueChartModel {
  final String month; // e.g., "Jan 2024"
  final double revenue;

  RevenueChartModel({required this.month, required this.revenue});

  factory RevenueChartModel.fromJson(Map<String, dynamic> json) {
    return RevenueChartModel(
      month: json['month'] ?? '',
      revenue: (json['revenue'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'month': month, 'revenue': revenue};
  }
}
