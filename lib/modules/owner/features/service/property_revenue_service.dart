import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class PropertyRevenueModel {
  final String month;
  final double revenue;

  PropertyRevenueModel({required this.month, required this.revenue});
}

class PropertyRevenueService {
  final supabase = Supabase.instance.client;

  Future<List<PropertyRevenueModel>> getRevenueForProperty(
    dynamic propertyId, {
    int months = 12,
  }) async {
    try {
      final int propId = propertyId is String
          ? int.parse(propertyId)
          : propertyId as int;

      final roomsResponse = await supabase
          .from('rooms')
          .select('id')
          .eq('property_id', propId);

      final roomIds = (roomsResponse as List).map((r) => r['id']).toList();
      if (roomIds.isEmpty) return [];

      final contractsResponse = await supabase
          .from('contracts')
          .select('id')
          .inFilter('room_id', roomIds);

      final contractIds = (contractsResponse as List)
          .map((c) => c['id'])
          .toList();
      if (contractIds.isEmpty) return [];

      final invoicesResponse = await supabase
          .from('invoices')
          .select('id')
          .inFilter('contract_id', contractIds);

      final invoiceIds = (invoicesResponse as List)
          .map((i) => i['id'])
          .toList();
      if (invoiceIds.isEmpty) return [];

      final now = DateTime.now();

      final paymentsResponse = await supabase
          .from('payments')
          .select('amount, payment_date')
          .inFilter('invoice_id', invoiceIds)
          .eq('status', 'verified');

      final payments = (paymentsResponse as List);

      final Map<String, double> monthlyRevenue = {};

      for (int i = 0; i < months; i++) {
        final date = DateTime(now.year, now.month - months + 1 + i, 1);
        final key = DateFormat('yyyy-MM').format(date);
        monthlyRevenue[key] = 0;
      }

      for (var payment in payments) {
        if (payment['payment_date'] == null) continue;
        final paymentDate = DateTime.parse(payment['payment_date']);
        final key = DateFormat('yyyy-MM').format(paymentDate);
        final amount = (payment['amount'] as num).toDouble();
        if (monthlyRevenue.containsKey(key)) {
          monthlyRevenue[key] = (monthlyRevenue[key] ?? 0) + amount;
        }
      }

      final sortedKeys = monthlyRevenue.keys.toList()..sort();

      return sortedKeys.map((key) {
        final date = DateFormat('yyyy-MM').parse(key);
        final monthName = DateFormat('MMM').format(date);
        return PropertyRevenueModel(
          month: monthName,
          revenue: monthlyRevenue[key]!,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
