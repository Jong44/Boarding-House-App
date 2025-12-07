class DashboardContractsModel {
  final int totalContractsActive;
  final int totalContractsExpiringSoon;
  final int totalContractsNews;

  DashboardContractsModel({
    required this.totalContractsActive,
    required this.totalContractsExpiringSoon,
    required this.totalContractsNews,
  });

  factory DashboardContractsModel.fromMap(Map<String, dynamic> map) {
    return DashboardContractsModel(
      totalContractsActive: map['total_contracts_active'] as int? ?? 0,
      totalContractsExpiringSoon:
          map['total_contracts_expiring_soon'] as int? ?? 0,
      totalContractsNews: map['total_contracts_news'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_contracts_active': totalContractsActive,
      'total_contracts_expiring_soon': totalContractsExpiringSoon,
      'total_contracts_news': totalContractsNews,
    };
  }

  @override
  String toString() {
    return 'DashboardContractsModel{totalContractsActive: $totalContractsActive, totalContractsExpiringSoon: $totalContractsExpiringSoon, totalContractsNews: $totalContractsNews}';
  }
}
