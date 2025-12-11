import 'package:boarding_house_app/models/tenant_user_model.dart';

class AppUser {
  final int? id;
  final String? fullName;
  final String? email;
  final String? role;
  final String? phoneNumber;
  final TenantUserModel? tenantDetails;

  AppUser({
    this.id,
    this.fullName = '',
    this.email,
    this.role = "tenant",
    this.phoneNumber = '',
    this.tenantDetails,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {

    return AppUser(
      id: map['id'] as int?,
      fullName: map['full_name'] as String?,
      email: map['email'] as String?,
      role: map['role'] as String?,
      phoneNumber: map['phone'] as String?,
      tenantDetails: map['tenant_profile'] != null
          ? TenantUserModel.fromMap(
              (map['tenant_profile'] as List)
                      .where((item) => item['user_id'] == map['id'])
                      .first
                  as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'role': role,
      'phone': phoneNumber,
    };
  }

  @override
  String toString() {
    return 'AppUser{id: $id, fullName: $fullName, email: $email, role: $role, phoneNumber: $phoneNumber}';
  }
}
