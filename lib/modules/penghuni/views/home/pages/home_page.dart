import 'package:boarding_house_app/modules/penghuni/views/home/components/announcement_card.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/contract_status.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/header_home.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/maintenance_status.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/payment_card.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/quick_actions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderHome(),
              const SizedBox(height: 24),

              ContractStatus(),
              const SizedBox(height: 20),

              PaymentCard(),
              const SizedBox(height: 24),

              // 6. Announcements
              const Text(
                'Announcements',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 16),
              AnnouncementCard(),
              const SizedBox(height: 20),

              // 5. Status Maintenance
              const Text(
                'Maintenance Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 16),
              MaintenanceStatus(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
