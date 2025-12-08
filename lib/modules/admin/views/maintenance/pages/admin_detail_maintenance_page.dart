import 'package:boarding_house_app/modules/admin/features/models/maintenance_model.dart';
import 'package:boarding_house_app/modules/admin/features/notifier/admin_maintenance_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_maintenance_action_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_maintenance_provider.dart';
import 'package:boarding_house_app/modules/admin/views/maintenance/pages/admin_list_maintenance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Detail Page
class AdminDetailMaintenancePage extends ConsumerStatefulWidget {
  final MaintenanceModel ticket;

  const AdminDetailMaintenancePage({Key? key, required this.ticket})
    : super(key: key);

  @override
  ConsumerState<AdminDetailMaintenancePage> createState() =>
      _AdminDetailMaintenancePageState();
}

class _AdminDetailMaintenancePageState
    extends ConsumerState<AdminDetailMaintenancePage> {
  String currentStatus = '';
  String assignedTechnician = 'Not Assigned';
  final TextEditingController noteController = TextEditingController();
  List<String> activityLogs = [];

  @override
  void initState() {
    super.initState();
    currentStatus = widget.ticket.status ?? 'Pending';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending' || 'open':
        return Colors.orange;
      case 'In Progress' || 'in_progress':
        return Colors.blue;
      case 'Completed' || 'completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Future<void> _handleStatusUpdate(String newStatus) async {
    if (newStatus == currentStatus) return;

    final newStatuss = newStatus.toLowerCase().replaceAll(' ', '_');

    await ref
        .read(AdminMaintenanceActionNotifierProvider.notifier)
        .updateStatus(widget.ticket.id!, newStatuss);

    await ref
        .read(adminMaintenanceNotifierProvider.notifier)
        .refreshMaintenances();

    setState(() {
      currentStatus = newStatus;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status berhasil diupdate ke $newStatus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(AdminMaintenanceActionNotifierProvider);

    if (state.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Ticket #${widget.ticket.id}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status & Priority Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Status',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(currentStatus).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentStatus,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: getStatusColor(currentStatus),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Tenant Information
            _buildSectionCard(
              title: 'Informasi Penyewa',
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.person_outline,
                    'Name',
                    widget.ticket.tenant?.fullName ?? 'N/A',
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    Icons.room_outlined,
                    'Room',
                    "Kamar ${widget.ticket.room?.id ?? 'N/A'}",
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    Icons.phone_outlined,
                    'Phone',
                    '+62 812 3456 7890',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Ticket Details
            _buildSectionCard(
              title: 'Detail Ticket',
              child: Column(
                children: [
                  const Divider(height: 24),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    'Created At',
                    _formatDate(widget.ticket.createdAt),
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    Icons.description_outlined,
                    'Description',
                    widget.ticket.description ?? 'Deskripsi Belum Tersedia',
                    isLong: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed:
                    currentStatus == 'Completed' || currentStatus == 'Cancelled'
                    ? null
                    : () {
                        _showStatusUpdateDialog();
                      },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFFFF5722)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Update Status',
                  style: TextStyle(
                    color: Color(0xFFFF5722),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: currentStatus == 'Completed'
                    ? null
                    : () {
                        _markAsCompleted();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Selesaikan',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    bool isLong = false,
  }) {
    return Row(
      crossAxisAlignment: isLong
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showStatusUpdateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusOption('Open'),
              _buildStatusOption('In Progress'),
              _buildStatusOption('Completed'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusOption(String status) {
    return ListTile(
      leading: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: getStatusColor(status),
          shape: BoxShape.circle,
        ),
      ),
      title: Text(status),
      onTap: () async {
        await _handleStatusUpdate(status);
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Status updated to $status')));
      },
    );
  }

  void _markAsCompleted() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selesaikan Ticket'),
          content: const Text(
            'Apakah Anda yakin ingin menandai ticket ini sebagai selesai?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _handleStatusUpdate('Completed');
                Navigator.pop(context);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ticket sudah selesai')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
              ),
              child: const Text('Selesaikan'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
