import 'package:boarding_house_app/modules/owner/views/property_detail/components/contract_info_card.dart';
import 'package:boarding_house_app/modules/owner/views/property_detail/components/maintenance_history.dart';
import 'package:boarding_house_app/modules/owner/views/property_detail/components/property_occupancy_chart.dart';
import 'package:boarding_house_app/modules/owner/views/property_detail/components/property_revenue_chart.dart';
import 'package:boarding_house_app/modules/owner/views/property_detail/components/property_stats_card.dart';
import 'package:boarding_house_app/modules/owner/views/property_detail/components/unit_list.dart';
import 'package:flutter/material.dart';

class PropertyDetailPage extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyDetailPage({Key? key, required this.property})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKontrakan = (property['totalUnits'] as int) == 1;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2D2D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          property['name'] as String,
          style: const TextStyle(
            color: Color(0xFF2D2D2D),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyStatsCard(property: property),
            const SizedBox(height: 16),
            if (isKontrakan) ...[
              ContractInfoCard(property: property),
              const SizedBox(height: 16),
            ] else ...[
              UnitList(property: property),
              const SizedBox(height: 16),
            ],
            PropertyRevenueChart(property: property),
            const SizedBox(height: 16),
            PropertyOccupancyChart(property: property),
            const SizedBox(height: 16),
            MaintenanceHistory(property: property),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
