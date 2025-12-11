class OwnerMaintenanceModel {
  final int pendingTickets;
  final int inProgressTickets;
  final double monthlyMaintenanceCost;

  OwnerMaintenanceModel({
    required this.pendingTickets,
    required this.inProgressTickets,
    required this.monthlyMaintenanceCost,
  });

  factory OwnerMaintenanceModel.fromJson(Map<String, dynamic> json) {
    return OwnerMaintenanceModel(
      pendingTickets: json['pending_tickets'] ?? 0,
      inProgressTickets: json['in_progress_tickets'] ?? 0,
      monthlyMaintenanceCost: (json['monthly_maintenance_cost'] ?? 0)
          .toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pending_tickets': pendingTickets,
      'in_progress_tickets': inProgressTickets,
      'monthly_maintenance_cost': monthlyMaintenanceCost,
    };
  }

  @override
  String toString() {
    return 'OwnerMaintenanceModel{pendingTickets: $pendingTickets, inProgressTickets: $inProgressTickets, monthlyMaintenanceCost: $monthlyMaintenanceCost}';
  }
}
