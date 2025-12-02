import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/models/room_model.dart';

class ContractModel {
  final int? id;
  final int tenantId;
  final int roomId;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final String contractType;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AppUser? tenantDetails;
  final RoomModel? roomDetails;

  ContractModel({
    this.id,
    required this.tenantId,
    required this.roomId,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.contractType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.tenantDetails,
    this.roomDetails,
  });

  factory ContractModel.fromMap(Map<String, dynamic> map) {
    return ContractModel(
      id: map['id'] as int?,
      tenantId: map['tenant_id'] as int,
      roomId: map['room_id'] as int,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: DateTime.parse(map['end_date'] as String),
      price: (map['price'] as num).toDouble(),
      contractType: map['contract_type'] as String,
      status: map['status'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      tenantDetails: map['tenants'] != null
          ? AppUser.fromMap(map['tenants'] as Map<String, dynamic>)
          : null,
      roomDetails: map['rooms'] != null
          ? RoomModel.fromMap(map['rooms'] as Map<String, dynamic>)
          : null,



    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tenant_id': tenantId,
      'room_id': roomId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'price': price,
      'contract_type': contractType,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'tenants': tenantDetails?.toMap(),
      'rooms': roomDetails?.toMap(),
    };
  }

  @override
  String toString() {
    return 'ContractModel{id: $id, tenantId: $tenantId,  roomId: $roomId, startDate: $startDate, endDate: $endDate, price: $price, contractType: $contractType, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, tenantDetails: $tenantDetails}';
  }
}
