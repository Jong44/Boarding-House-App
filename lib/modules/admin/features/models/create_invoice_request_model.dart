class CreateInvoiceRequestModel {
  final int contractId;
  final bool isAvailableInvoice;
  final double amount;
  final String categoryContract;

  final Map<String, String> errors = {};

  CreateInvoiceRequestModel({
    required this.contractId,
    required this.amount,
    required this.isAvailableInvoice,
    this.categoryContract = "monthly",
  });

  bool validate() {
    errors.clear();

    // contract id
    if (contractId <= 0) {
      errors['contract_id'] = 'Contract ID diperlukan.';
    }

    // jika invoice udah ada
    if (isAvailableInvoice) {
      errors['is_available_invoice'] =
          'Invoice sudah dibuat untuk periode ini.';
    }

    // total amount
    if (amount <= 0) {
      errors['total_amount'] = 'Jumlah harus lebih besar dari 0.';
    }

    // categoryContract validation
    const validCategories = ['monthly', 'yearly'];
    if (!validCategories.contains(categoryContract)) {
      errors['category'] = 'Kategori invoice tidak valid.';
    }

    return errors.isEmpty;
  }

  DateTime _safeAddMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, date.day > 28 ? 28 : date.day);
  }

  Map<String, dynamic> toMap() {
    final startDate = DateTime.now();

    final dueDate = categoryContract == "monthly"
        ? _safeAddMonth(startDate)
        : DateTime(startDate.year + 1, startDate.month, startDate.day);

    return {
      'contract_id': contractId,
      'issue_date': startDate.toIso8601String(),
      'due_date': dueDate.toIso8601String(),
      'total_amount': amount,
      'status': 'unpaid',
    };
  }
}
