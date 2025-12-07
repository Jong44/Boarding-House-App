class OwnerInvoiceModel {
  final int overdueCount;
  final double overdueAmount;

  OwnerInvoiceModel({required this.overdueCount, required this.overdueAmount});

  factory OwnerInvoiceModel.fromJson(Map<String, dynamic> json) {
    return OwnerInvoiceModel(
      overdueCount: json['overdue_count'] ?? 0,
      overdueAmount: (json['overdue_amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'overdue_count': overdueCount, 'overdue_amount': overdueAmount};
  }

  @override
  String toString() {
    return 'OwnerInvoiceModel{overdueCount: $overdueCount, overdueAmount: $overdueAmount}';
  }
}
