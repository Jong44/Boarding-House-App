import 'package:boarding_house_app/modules/admin/views/dashboard/components/maintenance_card.dart';
import 'package:boarding_house_app/modules/admin/views/dashboard/components/revenue_card.dart';
import 'package:boarding_house_app/modules/admin/views/dashboard/components/room_status_card.dart';
import 'package:boarding_house_app/modules/admin/views/dashboard/components/tenants_summary_card.dart';
import 'package:flutter/material.dart';

class DashboardAdminPage extends StatefulWidget {
  const DashboardAdminPage({Key? key}) : super(key: key);

  @override
  State<DashboardAdminPage> createState() => _DashboardAdminPageState();
}

class _DashboardAdminPageState extends State<DashboardAdminPage> {
  final tickets = [
    {
      'title': 'Keran bocor',
      'room': 'Room A-12',
      'time': '1 hari',
      'urgent': true,
    },
    {
      'title': 'Lampu mati',
      'room': 'Room B-03',
      'time': '3 jam',
      'urgent': true,
    },
    {
      'title': 'AC tidak dingin',
      'room': 'Room C-05',
      'time': '5 jam',
      'urgent': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TenantsSummaryCard(),
            const SizedBox(height: 10),
            RoomStatusCard(),
            const SizedBox(height: 10),
            const RevenueCard(),
            const SizedBox(height: 10),
            MaintenanceCard(tickets: {'tickets': tickets}),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}
