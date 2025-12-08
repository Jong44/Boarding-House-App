import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/invoice_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/create_invoice_request_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_dashboard_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_invoice_actions_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_tenants_provider.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/components/tab-detail/admin_tenant_contract_tab.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/components/tab-detail/admin_tenant_history_tab.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/components/tab-detail/admin_tenant_info_tab.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/components/tab-detail/admin_tenant_payment_tab.dart';
import 'package:boarding_house_app/utils/format_currency.dart';
import 'package:boarding_house_app/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminDetailTenantPage extends ConsumerStatefulWidget {
  final ContractModel contract;
  const AdminDetailTenantPage({Key? key, required this.contract})
    : super(key: key);

  @override
  ConsumerState<AdminDetailTenantPage> createState() =>
      _AdminDetailTenantPageState(contract: contract);
}

class _AdminDetailTenantPageState extends ConsumerState<AdminDetailTenantPage>
    with SingleTickerProviderStateMixin {
  final ContractModel contract;
  _AdminDetailTenantPageState({required this.contract});
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> _refreshData() async {
    await ref.read(adminTenantsProvider.notifier).refreshContracts();
    await ref.read(dashboardProvider.notifier).refreshAll();
  }

  Future<void> _handleCreateInvoice(
    BuildContext context,
    AsyncValue<void> invoiceState,
  ) async {
    if (contract.status!.toLowerCase() != 'active') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Tidak dapat membuat invoice untuk kontrak yang tidak aktif.',
          ),
        ),
      );
      return;
    }
    if (invoiceState.isLoading) {
      return;
    }
    final request = CreateInvoiceRequestModel(
      contractId: contract.id ?? 0,
      amount: contract.price,
      isAvailableInvoice:
          contract.invoices != null &&
          contract.invoices!.any((invoice) {
            final now = DateTime.now();
            return invoice.issueDate.year == now.year &&
                invoice.issueDate.month == now.month;
          }),
    );

    if (!request.validate()) {
      // Show error messages
      final errorMessages = request.errors.values.join('\n');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessages)));
      return;
    }

    ref
        .read(adminInvoiceActionNotifierProvider.notifier)
        .createInvoice(request.toMap())
        .then((_) async {
          await _refreshData();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invoice berhasil dibuat.')),
          );
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal membuat invoice: $error')),
          );
        });
  }

  Future<void> _handleEndContract(
    BuildContext context,
    AsyncValue<void> invoiceState,
  ) async {
    if (contract.status!.toLowerCase() != 'active') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat mengakhiri kontrak yang tidak aktif.'),
        ),
      );
      return;
    }
    if (invoiceState.isLoading) {
      return;
    }

    ref
        .read(adminInvoiceActionNotifierProvider.notifier)
        .endedContract(contract.id ?? 0)
        .then((_) async {
          await _refreshData();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kontrak berhasil diakhiri.')),
          );
        })
        .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengakhiri kontrak: $error')),
          );
        });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'cancelled':
        return Colors.orange;
      case 'ended':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Aktif';
      case 'ended':
        return 'Kadaluarsa';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return 'Tidak Diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = ref.watch(adminInvoiceActionNotifierProvider);
    if (invoiceState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Detail Penyewa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  InkWell(onTap: () {}, child: const Icon(Icons.more_vert)),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Profile Section
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFED7AA),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Color(0xFFFF5722),
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            contract.tenantDetails?.fullName ?? '',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                contract.status ?? '',
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getStatusText(contract.status ?? ''),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(contract.status ?? ''),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Tab Bar
                    Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: const Color(0xFFFF5722),
                        unselectedLabelColor: const Color(0xFF9CA3AF),
                        indicatorColor: const Color(0xFFFF5722),
                        indicatorWeight: 3,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        tabs: const [
                          Tab(text: 'Info'),
                          Tab(text: 'Kontrak'),
                          Tab(text: 'Pembayaran'),
                          Tab(text: 'Riwayat'),
                        ],
                      ),
                    ),

                    // Tab Content
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          AdminTenantInfoTab(contract: contract),
                          AdminTenantContractTab(contract: contract),
                          AdminTenantPaymentTab(contract: contract),
                          AdminTenantHistoryTab(contract: contract),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Action Buttons
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _handleCreateInvoice(context, invoiceState);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Kirim Invoice',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _handleEndContract(context, invoiceState);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Akhiri Kontrak',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
