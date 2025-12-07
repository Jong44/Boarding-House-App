class TenantUserModel {
  final int? id;
  final int? userId;
  final DateTime? birthDate;
  final String? address;

  TenantUserModel({this.id, this.userId, this.birthDate, this.address});

  factory TenantUserModel.fromMap(Map<String, dynamic> map) {
    return TenantUserModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int?,
      birthDate: map['birth_date'] != null
          ? DateTime.parse(map['birth_date'] as String)
          : null,
      address: map['address'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'birth_date': birthDate?.toIso8601String(),
      'address': address,
    };
  }
}
