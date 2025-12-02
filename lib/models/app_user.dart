class AppUser {
  final int? id;
  final String? fullName;
  final String email;
  final String? role;
  final String? phoneNumber;

  AppUser({
    this.id,
    this.fullName,
    required this.email,
    this.role,
    this.phoneNumber,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] as int?,
      fullName: map['full_name'] as String?,
      email: map['email'] as String,
      role: map['role'] as String?,
      phoneNumber: map['phone_number'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'role': role,
      'phone_number': phoneNumber,
    };
  }

  @override
  String toString() {
    return 'AppUser{id: $id, fullName: $fullName, email: $email, role: $role, phoneNumber: $phoneNumber}';
  }
}
