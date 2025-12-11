import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<Map<String, dynamic>> getPaymentSummary() async {
    final response = await supabase
        .from('payments')
        .select(
          '*, invoices:invoice_id (contracts:contract_id (rooms:room_id (properties:property_id (owner_id)))))',
        );

    final data = (response as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    final totalIncome = data.fold<double>(
      0.0,
      (sum, payment) => sum + (payment['amount'] as num).toDouble(),
    );

    final trendData = data
        .where((payment) {
          final paymentDate = DateTime.parse(payment['created_at'] as String);
          return paymentDate.isAfter(
            DateTime.now().subtract(const Duration(days: 30)),
          );
        })
        .fold<double>(
          0.0,
          (sum, payment) => sum + (payment['amount'] as num).toDouble(),
        );

    return {'totalIncome': totalIncome, 'trendData': trendData};
  }
}
