import 'package:boarding_house_app/models/invoice_model.dart';

class TenantInvoicesState {
  final bool isLoading;
  final List<InvoiceModel> invoices;
  final String? errorMessage;

  TenantInvoicesState({
    this.isLoading = false,
    this.invoices = const [],
    this.errorMessage,
  });

  TenantInvoicesState copyWith({
    bool? isLoading,
    List<InvoiceModel>? invoices,
    String? errorMessage,
  }) {
    return TenantInvoicesState(
      isLoading: isLoading ?? this.isLoading,
      invoices: invoices ?? this.invoices,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
