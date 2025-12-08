class PaymentModel {
  final int? id;
  final int? invoiceId;
  final double amount;
  final DateTime paymentDate;
  final String method;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? proofDocument;

  PaymentModel({
    this.id,
    required this.invoiceId,
    required this.amount,
    required this.paymentDate,
    required this.method,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.proofDocument,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    print(map.toString());
    return PaymentModel(
      id: map['id'] as int?,
      invoiceId: map['invoice_id'] as int?,
      amount: (map['amount'] as num).toDouble(),
      paymentDate: DateTime.parse(map['payment_date'] as String? ?? ''),
      method: map['method'] as String? ?? "cash",
      status: map['status'] as String? ?? "pending",
      createdAt: DateTime.parse(map['created_at'] as String? ?? ''),
      updatedAt: DateTime.parse(map['updated_at'] as String? ?? ''),
      proofDocument: map['proof_document'] as String? ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoice_id': invoiceId,
      'amount': amount,
      'payment_date': paymentDate.toIso8601String(),
      'method': method,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'proof_document': proofDocument,
    };
  }

  @override
  String toString() {
    return 'PaymentModel{id: $id, invoiceId: $invoiceId, amount: $amount, paymentDate: $paymentDate, method: $method, status: $status, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
