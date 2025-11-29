import 'package:boarding_house_app/modules/penghuni/shared/bottom_navbar.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/pages/home_page.dart';
import 'package:boarding_house_app/modules/penghuni/views/invoice/pages/invoice_page.dart';
import 'package:boarding_house_app/modules/penghuni/views/maintenance/pages/maintenance_page.dart';
import 'package:boarding_house_app/modules/penghuni/views/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const InvoicesPage(),
    const MaintenancePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
