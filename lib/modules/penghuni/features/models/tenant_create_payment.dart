class TenantCreatePayment {
  final String method;
  final String category;
  final double amount;
  final String? paymentProof;

  final Map<String, String> errors = {};

  TenantCreatePayment({
    required this.method,
    required this.category,
    required this.amount,
    this.paymentProof,
  });

  bool validate() {
    errors.clear();

    // method validation
    const validMethods = ['Bank Transfer', 'Cash'];
    if (!validMethods.contains(method)) {
      errors['method'] = 'Metode pembayaran tidak valid.';
    }

    // amount validation
    if (amount <= 0) {
      errors['amount'] = 'Jumlah pembayaran harus lebih dari nol.';
    }

    // category validation
    const validCategories = ['Partial', 'Full'];
    if (!validCategories.contains(category)) {
      errors['category'] = 'Kategori pembayaran tidak valid.';
    }
    return errors.isEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'category': category,
      'amount': amount,
      'proof_document': paymentProof,
    };
  }
}
