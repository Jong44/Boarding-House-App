import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/modules/penghuni/features/provider/tenant_dashboard_provider.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/announcement_card.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/contract_status.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/header_home.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/maintenance_status.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/payment_card.dart';
import 'package:boarding_house_app/modules/penghuni/views/home/components/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tenantDashboardState = ref.watch(tenantDashboardProvider);

    if (tenantDashboardState.isLoadingContract ||
        tenantDashboardState.isLoadingInvoice ||
        tenantDashboardState.isLoadingMaintenance ||
        tenantDashboardState.isLoadingProfile) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tenantDashboardState.errorContract != null ||
        tenantDashboardState.errorInvoice != null ||
        tenantDashboardState.errorMaintenance != null ||
        tenantDashboardState.errorProfile != null) {
      return Center(
        child: Text(
          'Error: ${tenantDashboardState.errorContract ?? tenantDashboardState.errorInvoice ?? tenantDashboardState.errorMaintenance ?? tenantDashboardState.errorProfile}',
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderHome(
                userName:
                    tenantDashboardState.userProfile?.fullName ?? 'Penghuni',
              ),
              const SizedBox(height: 24),

              ContractStatus(
                contract:
                    tenantDashboardState.contract ??
                    ContractModel(
                      tenantId: 0,
                      roomId: 0,
                      startDate: DateTime.now(),
                      endDate: DateTime.now(),
                      price: 0.0,
                      contractType: "monthly",
                      status: "inactive",
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
              ),
              const SizedBox(height: 20),

              PaymentCard(contract: tenantDashboardState.contract),
              const SizedBox(height: 24),

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
              MaintenanceStatus(
                maintenances: tenantDashboardState.maintenance ?? [],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
