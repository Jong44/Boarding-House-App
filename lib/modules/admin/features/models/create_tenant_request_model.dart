class CreateTenantRequestModel {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String address;
  final DateTime startDate;
  final double price;

  final int propertyId = 1;
  final int roomId;

  final String categoryContract;

  final Map<String, String> errors = {};

  CreateTenantRequestModel({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.startDate,
    required this.price,
    required this.roomId,
    required this.categoryContract,
  });

  bool validate() {
    errors.clear();

    // full name
    if (fullName.isEmpty) {
      errors['full_name'] = 'Nama lengkap diperlukan.';
    }

    // phone number
    if (phoneNumber.isEmpty) {
      errors['phone_number'] = 'Nomor telepon diperlukan.';
    }

    // email
    if (email.isEmpty) {
      errors['email'] = 'Email diperlukan.';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      errors['email'] = 'Format email tidak valid.';
    }

    // address
    if (address.isEmpty) {
      errors['address'] = 'Alamat diperlukan.';
    }

    // categoryContract validation
    const validCategories = ['monthly', 'yearly'];
    if (!validCategories.contains(categoryContract)) {
      errors['category'] = 'Kategori kontrak tidak valid.';
    }

    return errors.isEmpty;
  }

  Map<String, dynamic> toMap() {
    final DateTime endDate = startDate.add(
      categoryContract == 'monthly' ? Duration(days: 30) : Duration(days: 365),
    );

    return {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'email': email,
      'address': address,
      'property_id': propertyId,
      'room_id': roomId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'price': price,
      'category_contract': categoryContract,
    };
  }
}
