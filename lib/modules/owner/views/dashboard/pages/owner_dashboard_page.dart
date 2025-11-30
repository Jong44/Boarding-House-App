import 'package:boarding_house_app/modules/owner/views/dashboard/components/facility_revenue_card.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/invoice_overdue_card.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/maintenance_overview_card.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/occupancy_card.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/occupancy_trend_chart.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/revenue_chart.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/revenue_summary_card.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/room_status_card.dart';
import 'package:boarding_house_app/modules/owner/views/dashboard/components/top_rooms_card.dart';
import 'package:flutter/material.dart';

class OwnerDashboardPage extends StatelessWidget {
  const OwnerDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RevenueSummaryCard(),
            const SizedBox(height: 16),
            const OccupancyCard(),
            const SizedBox(height: 16),
            const RoomStatusCard(),
            const SizedBox(height: 16),
            const TopRoomsCard(),
            const SizedBox(height: 16),
            const InvoiceOverdueCard(),
            const SizedBox(height: 16),
            const MaintenanceOverviewCard(),
            const SizedBox(height: 16),
            const RevenueChart(),
            const SizedBox(height: 16),
            const OccupancyTrendChart(),
            const SizedBox(height: 16),
            const FacilityRevenueCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
