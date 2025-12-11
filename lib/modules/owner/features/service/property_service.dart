import 'package:boarding_house_app/modules/owner/features/models/property_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertyService {
  final supabase = Supabase.instance.client;

  Future<List<PropertyModel>> getProperties() async {
    try {
      final propsResponse = await supabase
          .from('properties')
          .select('id, name, address');

      final properties = <PropertyModel>[];

      for (var prop in propsResponse as List) {
        final propId = prop['id'];

        final roomsResponse = await supabase
            .from('rooms')
            .select('id, status')
            .eq('property_id', propId);

        final rooms = roomsResponse as List;
        final totalUnits = rooms.length;
        final occupiedUnits = rooms
            .where((r) => r['status'] == 'occupied')
            .length;

        final revenue = await _getMonthlyRevenue(propId);

        properties.add(
          PropertyModel(
            id: propId,
            name: prop['name'],
            address: prop['address'],
            totalUnits: totalUnits,
            occupiedUnits: occupiedUnits,
            monthlyRevenue: revenue,
          ),
        );
      }

      return properties;
    } catch (e) {
      return [];
    }
  }

  Future<double> _getMonthlyRevenue(int propertyId) async {
    try {
      final now = DateTime.now();
      final currentYear = now.year;
      final currentMonth = now.month;

      final roomsResponse = await supabase
          .from('rooms')
          .select('id')
          .eq('property_id', propertyId);

      final roomIds = (roomsResponse as List).map((r) => r['id']).toList();

      if (roomIds.isEmpty) return 0.0;

      final contractsResponse = await supabase
          .from('contracts')
          .select('id')
          .inFilter('room_id', roomIds);

      final contractIds = (contractsResponse as List)
          .map((c) => c['id'])
          .toList();

      if (contractIds.isEmpty) return 0.0;

      final invoicesResponse = await supabase
          .from('invoices')
          .select('id')
          .inFilter('contract_id', contractIds);

      final invoiceIds = (invoicesResponse as List)
          .map((i) => i['id'])
          .toList();

      if (invoiceIds.isEmpty) return 0.0;

      final paymentsResponse = await supabase
          .from('payments')
          .select('amount, payment_date, status')
          .inFilter('invoice_id', invoiceIds);

      final payments = (paymentsResponse as List)
          .map((e) => e as Map<String, dynamic>)
          .toList();

      double monthlyRevenue = 0;
      for (var payment in payments) {
        if (payment['status'] != 'verified') continue;

        if (payment['payment_date'] != null) {
          final paymentDate = DateTime.parse(payment['payment_date']);
          if (paymentDate.year == currentYear &&
              paymentDate.month == currentMonth) {
            monthlyRevenue += (payment['amount'] ?? 0).toDouble();
          }
        }
      }

      return monthlyRevenue;
    } catch (e) {
      return 0.0;
    }
  }
}
