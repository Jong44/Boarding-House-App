import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/payment_model.dart';

class InvoiceModel {
  final int? id;
  final int contractId;
  final DateTime issueDate;
  final DateTime dueDate;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PaymentModel>? payments;
  final ContractModel? contract;

  InvoiceModel({
    this.id,
    required this.contractId,
    required this.issueDate,
    required this.dueDate,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.payments,
    this.contract,
  });

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] as int?,
      contractId: map['contract_id'] as int,
      issueDate: DateTime.parse(map['issue_date'] as String),
      dueDate: DateTime.parse(map['due_date'] as String),
      totalAmount: (map['total_amount'] as num).toDouble(),
      status: map['status'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      payments: map['payments'] != null
          ? (map['payments'] as List)
                .map((e) => PaymentModel.fromMap(e as Map<String, dynamic>))
                .toList()
          : null,
      contract: map['contracts'] != null
          ? ContractModel.fromMap(map['contracts'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contract_id': contractId,
      'issue_date': issueDate.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'total_amount': totalAmount,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'payments': payments?.map((x) => x.toMap()).toList(),
      'contract': contract?.toMap(),
    };
  }

  @override
  String toString() {
    return 'InvoiceModel{id: $id, contractId: $contractId, issueDate: $issueDate, dueDate: $dueDate, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
