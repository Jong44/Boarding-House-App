import 'package:boarding_house_app/modules/owner/features/models/owner_revenue_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerRevenueService {
  final supabase = Supabase.instance.client;

  Future<OwnerRevenueModel> getRevenueSummary() async {
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    try {
      final paymentsResponse = await supabase
          .from('payments')
          .select('amount, payment_date')
          .eq('status', 'verified'); // Use correct enum value

      final payments = (paymentsResponse as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      double monthlyRevenue = 0;
      for (var payment in payments) {
        if (payment['payment_date'] != null) {
          final paymentDate = DateTime.parse(payment['payment_date']);
          if (paymentDate.year == currentYear &&
              paymentDate.month == currentMonth) {
            monthlyRevenue += (payment['amount'] ?? 0).toDouble();
          }
        }
      }

      double yearlyRevenue = 0;
      for (var payment in payments) {
        if (payment['payment_date'] != null) {
          final paymentDate = DateTime.parse(payment['payment_date']);
          if (paymentDate.year == currentYear) {
            yearlyRevenue += (payment['amount'] ?? 0).toDouble();
          }
        }
      }

      return OwnerRevenueModel(
        monthlyRevenue: monthlyRevenue,
        yearlyRevenue: yearlyRevenue,
      );
    } catch (e) {
      return OwnerRevenueModel(monthlyRevenue: 0, yearlyRevenue: 0);
    }
  }
}
