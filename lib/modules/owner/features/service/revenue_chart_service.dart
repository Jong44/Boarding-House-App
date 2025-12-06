import 'package:boarding_house_app/modules/owner/features/models/revenue_chart_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class RevenueChartService {
  final supabase = Supabase.instance.client;

  Future<List<RevenueChartModel>> getMonthlyRevenue({int months = 6}) async {
    try {
      final now = DateTime.now();
      final startDate = DateTime(now.year, now.month - months, 1);

      final response = await supabase
          .from('payments')
          .select('amount, payment_date, status')
          .gte('payment_date', startDate.toIso8601String());

      final data = (response as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      final Map<String, Map<String, dynamic>> monthlyData = {};

      for (var payment in data) {
        if (payment['status'] != 'verified') {
          continue;
        }

        if (payment['payment_date'] != null) {
          final date = DateTime.parse(payment['payment_date']);
          final sortKey = DateFormat('yyyy-MM').format(date);
          final displayMonth = DateFormat('MMM').format(date);

          if (!monthlyData.containsKey(sortKey)) {
            monthlyData[sortKey] = {'month': displayMonth, 'revenue': 0.0};
          }

          monthlyData[sortKey]!['revenue'] =
              (monthlyData[sortKey]!['revenue'] as double) +
              (payment['amount'] ?? 0).toDouble();
        }
      }

      final sortedKeys = monthlyData.keys.toList()..sort();

      final chartData = sortedKeys.map((key) {
        return RevenueChartModel(
          month: monthlyData[key]!['month'] as String,
          revenue: monthlyData[key]!['revenue'] as double,
        );
      }).toList();

      return chartData;
    } catch (e) {
      return [];
    }
  }
}
