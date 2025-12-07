import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/modules/admin/views/tenants/pages/admin_detail_tenant_page.dart';
import 'package:flutter/material.dart';

class AdminTenantCard extends StatelessWidget {
  final ContractModel tenant;
  const AdminTenantCard({super.key, required this.tenant});

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

  String _getStatusBasedOnDates(
    DateTime startDate,
    DateTime endDate,
    String status,
  ) {
    if (status != 'active') {
      return _getStatusText(status);
    }
    final now = DateTime.now();
    if (now.isBefore(endDate) &&
        endDate.isBefore(now.add(const Duration(days: 7)))) {
      return 'ending_soon';
    } else if (now.isAfter(endDate)) {
      return 'ended';
    } else {
      return 'active';
    }
  }

  String _formatCurrency(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => AdminDetailTenantPage(contract: tenant),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  tenant.tenantDetails?.fullName ?? '',
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
                                      'Kamar ${tenant.roomDetails?.id ?? ''}',
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
                              color: _getStatusColor(tenant.status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getStatusText(
                                _getStatusBasedOnDates(
                                  tenant.startDate,
                                  tenant.endDate,
                                  tenant.status,
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getStatusTextColor(tenant.status),
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
                                  _formatCurrency(tenant.price.toInt()),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
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
}
