import 'package:boarding_house_app/modules/admin/features/provider/admin_tenants_provider.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/components/admin_stat_card_list_tenants.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/components/admin_tenant_card.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/pages/admin_create_tenant_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminTenantsPage extends ConsumerStatefulWidget {
  const AdminTenantsPage({super.key});

  @override
  ConsumerState<AdminTenantsPage> createState() => _AdminTenantsPageState();
}

class _AdminTenantsPageState extends ConsumerState<AdminTenantsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminTenantsProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    final tenants = state.contracts['contracts'] ?? [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Cari nama, nomor HP, nomor kamar...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            // Filter Panel
            // Stats Summary
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: AdminStatCardListTenants(
                      label: '28',
                      value: 'Aktif',
                      bgColor: const Color(0xFFD1FAE5),
                      textColor: const Color(0xFF059669),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AdminStatCardListTenants(
                      label: '5',
                      value: 'Segera Berakhir',
                      bgColor: const Color(0xFFFED7AA),
                      textColor: const Color(0xFFEA580C),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AdminStatCardListTenants(
                      label: '3',
                      value: 'Menunggak',
                      bgColor: const Color(0xFFFEE2E2),
                      textColor: const Color(0xFFDC2626),
                    ),
                  ),
                ],
              ),
            ),
            // Tenant List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: tenants.length,
                itemBuilder: (context, index) {
                  return AdminTenantCard(tenant: tenants[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminCreateTenantPage(),
            ),
          );
        },
        backgroundColor: const Color(0xFFFF5722),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
