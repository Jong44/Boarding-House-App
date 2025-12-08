import 'package:boarding_house_app/modules/admin/views/dashboard/pages/admin_dashboard_page.dart';
import 'package:boarding_house_app/modules/admin/views/maintenance/pages/admin_list_maintenance_page.dart';
import 'package:boarding_house_app/modules/admin/views/property/pages/admin_property_page.dart';
import 'package:boarding_house_app/modules/admin/views/room_type/pages/admin_room_type_page.dart';
import 'package:boarding_house_app/modules/admin/views/rooms/pages/admin_rooms_page.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/pages/admin_tenants_page.dart';
import 'package:boarding_house_app/modules/auth/pages/login_page.dart';
import 'package:boarding_house_app/modules/penghuni/features/provider/tenant_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminIndexPage extends ConsumerStatefulWidget {
  const AdminIndexPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminIndexPage> createState() => _AdminIndexPageState();
}

class _AdminIndexPageState extends ConsumerState<AdminIndexPage> {
  int _selectedIndex = 0;

  final List<DrawerMenuItem> _menuItems = [
    DrawerMenuItem(icon: Icons.dashboard_rounded, title: 'Dashboard', index: 0),
    DrawerMenuItem(
      icon: Icons.people_rounded,
      title: 'Management Tenants',
      index: 1,
    ),
    DrawerMenuItem(
      icon: Icons.build_rounded,
      title: 'Maintenance Management',
      index: 2,
    ),
    DrawerMenuItem(
      icon: Icons.build_circle_rounded,
      title: 'Property Management',
      index: 3,
    ),
    DrawerMenuItem(
      icon: Icons.hotel_rounded,
      title: 'Room Types Management',
      index: 4,
    ),
    DrawerMenuItem(
      icon: Icons.meeting_room_rounded,
      title: 'Rooms Management',
      index: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF2D2D2D)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          _menuItems[_selectedIndex].title,
          style: const TextStyle(
            color: Color(0xFF2D2D2D),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF2D2D2D),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildDrawerHeader(),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _menuItems.length,
                  itemBuilder: (context, index) {
                    return _buildDrawerItem(_menuItems[index]);
                  },
                ),
              ),
              _buildDrawerFooter(),
            ],
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.apartment_rounded,
              color: Color(0xFFFF6B35),
              size: 35,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Property Admin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'admin@property.com',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(DrawerMenuItem item) {
    final isSelected = _selectedIndex == item.index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFFF6B35).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          item.icon,
          color: isSelected ? const Color(0xFFFF6B35) : const Color(0xFF757575),
          size: 24,
        ),
        title: Text(
          item.title,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFFFF6B35)
                : const Color(0xFF2D2D2D),
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onTap: () {
          setState(() {
            _selectedIndex = item.index;
          });
          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildDrawerFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.logout_rounded, color: Color(0xFFFF6B35)),
        title: const Text(
          'Logout',
          style: TextStyle(
            color: Color(0xFFFF6B35),
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {
          _showLogoutDialog();
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return DashboardAdminPage();
      case 1:
        return AdminTenantsPage();
      case 2:
        return AdminListMaintenancePage();
      case 3:
        return AdminPropertyPage();
      case 4:
        return AdminRoomTypePage();
      case 5:
        return AdminRoomsPage();
      default:
        return const Center(child: Text('Page Not Found'));
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(color: Color(0xFF757575)),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(tenantUserActionNotifierProvider.notifier)
                  .logout();
              if (!mounted) return;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class DrawerMenuItem {
  final IconData icon;
  final String title;
  final int index;

  DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.index,
  });
}
