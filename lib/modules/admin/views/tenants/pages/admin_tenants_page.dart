import 'package:boarding_house_app/modules/admin/views/tenants/pages/admin_create_tenant_page.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/pages/admin_detail_tenant_page.dart';
import 'package:flutter/material.dart';

class Tenant {
  final int id;
  final String name;
  final String room;
  final String type;
  final String contractStatus;
  final String paymentStatus;
  final int monthlyRent;
  final String phone;
  final String entryDate;

  Tenant({
    required this.id,
    required this.name,
    required this.room,
    required this.type,
    required this.contractStatus,
    required this.paymentStatus,
    required this.monthlyRent,
    required this.phone,
    required this.entryDate,
  });
}

class AdminTenantsPage extends StatefulWidget {
  const AdminTenantsPage({Key? key}) : super(key: key);

  @override
  State<AdminTenantsPage> createState() => _AdminTenantsPageState();
}

class _AdminTenantsPageState extends State<AdminTenantsPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showFilter = false;
  String _selectedStatus = 'all';
  String _selectedPropertyType = 'all';
  String _selectedPaymentStatus = 'all';
  int _selectedNavIndex = 2;

  final List<Tenant> _tenants = [
    Tenant(
      id: 1,
      name: 'Rina Putri',
      room: 'A-12',
      type: '3x4',
      contractStatus: 'active',
      paymentStatus: 'paid',
      monthlyRent: 1200000,
      phone: '081234567890',
      entryDate: '2024-01-15',
    ),
    Tenant(
      id: 2,
      name: 'Budi Santoso',
      room: 'B-05',
      type: '3x5',
      contractStatus: 'ending_soon',
      paymentStatus: 'unpaid',
      monthlyRent: 1500000,
      phone: '081234567891',
      entryDate: '2024-02-20',
    ),
    Tenant(
      id: 3,
      name: 'Siti Aminah',
      room: 'C-08',
      type: 'Type 45',
      contractStatus: 'active',
      paymentStatus: 'paid',
      monthlyRent: 2500000,
      phone: '081234567892',
      entryDate: '2024-03-10',
    ),
    Tenant(
      id: 4,
      name: 'Ahmad Fauzi',
      room: 'A-15',
      type: '3x4',
      contractStatus: 'ended',
      paymentStatus: 'overdue',
      monthlyRent: 1200000,
      phone: '081234567893',
      entryDate: '2023-12-01',
    ),
    Tenant(
      id: 5,
      name: 'Dewi Lestari',
      room: 'B-12',
      type: '3x5',
      contractStatus: 'active',
      paymentStatus: 'paid',
      monthlyRent: 1500000,
      phone: '081234567894',
      entryDate: '2024-04-05',
    ),
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return const Color(0xFFD1FAE5);
      case 'ending_soon':
        return const Color(0xFFFED7AA);
      case 'ended':
        return const Color(0xFFE5E7EB);
      default:
        return const Color(0xFFE5E7EB);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'active':
        return const Color(0xFF059669);
      case 'ending_soon':
        return const Color(0xFFEA580C);
      case 'ended':
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Kontrak Aktif';
      case 'ending_soon':
        return 'Segera Berakhir';
      case 'ended':
        return 'Kontrak Berakhir';
      default:
        return status;
    }
  }

  Color _getPaymentStatusColor(String status) {
    switch (status) {
      case 'paid':
        return const Color(0xFF059669);
      case 'unpaid':
        return const Color(0xFFEA580C);
      case 'overdue':
        return const Color(0xFFDC2626);
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _getPaymentStatusText(String status) {
    switch (status) {
      case 'paid':
        return 'Lunas';
      case 'unpaid':
        return 'Belum Bayar';
      case 'overdue':
        return 'Menunggak';
      default:
        return status;
    }
  }

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
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
            if (_showFilter) _buildFilterPanel(),
            // Stats Summary
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      '28',
                      'Aktif',
                      const Color(0xFFD1FAE5),
                      const Color(0xFF059669),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      '5',
                      'Segera Berakhir',
                      const Color(0xFFFED7AA),
                      const Color(0xFFEA580C),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      '3',
                      'Menunggak',
                      const Color(0xFFFEE2E2),
                      const Color(0xFFDC2626),
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
                itemCount: _tenants.length,
                itemBuilder: (context, index) {
                  return _buildTenantCard(_tenants[index]);
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

  Widget _buildFilterPanel() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Penghuni',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip('Semua', 'all', _selectedStatus),
              _buildFilterChip('Aktif', 'active', _selectedStatus),
              _buildFilterChip(
                'Segera Berakhir',
                'ending_soon',
                _selectedStatus,
              ),
              _buildFilterChip('Tidak Aktif', 'ended', _selectedStatus),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Jenis Properti',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                'Semua',
                'all',
                _selectedPropertyType,
                isPropertyType: true,
              ),
              _buildFilterChip(
                'Kost 3x4',
                '3x4',
                _selectedPropertyType,
                isPropertyType: true,
              ),
              _buildFilterChip(
                'Kost 3x5',
                '3x5',
                _selectedPropertyType,
                isPropertyType: true,
              ),
              _buildFilterChip(
                'Kontrakan Type 45',
                'type45',
                _selectedPropertyType,
                isPropertyType: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Status Pembayaran',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                'Semua',
                'all',
                _selectedPaymentStatus,
                isPaymentStatus: true,
              ),
              _buildFilterChip(
                'Lancar',
                'paid',
                _selectedPaymentStatus,
                isPaymentStatus: true,
              ),
              _buildFilterChip(
                'Menunggak',
                'overdue',
                _selectedPaymentStatus,
                isPaymentStatus: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    String value,
    String selected, {
    bool isPropertyType = false,
    bool isPaymentStatus = false,
  }) {
    bool isSelected = selected == value;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (isPropertyType) {
            _selectedPropertyType = value;
          } else if (isPaymentStatus) {
            _selectedPaymentStatus = value;
          } else {
            _selectedStatus = value;
          }
        });
      },
      selectedColor: const Color(0xFFFF5722),
      backgroundColor: const Color(0xFFF3F4F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    Color bgColor,
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTenantCard(Tenant tenant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminDetailTenantPage(),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFED7AA),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.person, color: Color(0xFFFF5722)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tenant.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.home_outlined,
                                      size: 14,
                                      color: Color(0xFF6B7280),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Room ${tenant.room} (${tenant.type})',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(tenant.contractStatus),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getStatusText(tenant.contractStatus),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusTextColor(
                                  tenant.contractStatus,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.only(top: 12),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color(0xFFF3F4F6)),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.payments_outlined,
                                  size: 16,
                                  color: Color(0xFF9CA3AF),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _formatCurrency(tenant.monthlyRent),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '• ${_getPaymentStatusText(tenant.paymentStatus)}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: _getPaymentStatusColor(
                                      tenant.paymentStatus,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'Detail →',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF5722),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
