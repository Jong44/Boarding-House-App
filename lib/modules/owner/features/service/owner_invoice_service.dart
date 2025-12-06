import 'package:boarding_house_app/modules/owner/features/models/owner_invoice_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerInvoiceService {
  final supabase = Supabase.instance.client;

  Future<OwnerInvoiceModel> getOverdueInvoices() async {
    final now = DateTime.now();

    try {
      final invoicesResponse = await supabase
          .from('invoices')
          .select('total_amount, due_date')
          .eq('status', 'unpaid');

      final invoices = (invoicesResponse as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      final overdueInvoices = invoices.where((invoice) {
        if (invoice['due_date'] == null) return false;
        final dueDate = DateTime.parse(invoice['due_date']);
        return dueDate.isBefore(now);
      }).toList();

      int overdueCount = overdueInvoices.length;
      double overdueAmount = 0;

      for (var invoice in overdueInvoices) {
        overdueAmount += (invoice['total_amount'] ?? 0).toDouble();
      }

      return OwnerInvoiceModel(
        overdueCount: overdueCount,
        overdueAmount: overdueAmount,
      );
    } catch (e) {
      return OwnerInvoiceModel(overdueCount: 0, overdueAmount: 0);
    }
  }
}
