import 'package:boarding_house_app/modules/admin/features/models/maintenance_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_maintenance_provider.dart';
import 'package:boarding_house_app/modules/admin/views/maintenance/pages/admin_detail_maintenance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminListMaintenancePage extends ConsumerStatefulWidget {
  const AdminListMaintenancePage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminListMaintenancePage> createState() =>
      _AdminListMaintenancePageState();
}

class _AdminListMaintenancePageState
    extends ConsumerState<AdminListMaintenancePage> {
  String selectedStatus = 'All';
  String selectedPriority = 'All';
  String searchQuery = '';

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
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

  String getTextStatus(String status) {
    switch (status) {
      case 'open':
        return 'Pending';
      case 'in_progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminMaintenanceNotifierProvider);

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.error != null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Error: ${state.error}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    final tickets = searchQuery == ''
        ? state.maintenances
        : state.maintenancesFiltered;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search tickets...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Filter Chips
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', selectedStatus == 'All', () {
                    setState(() => selectedStatus = 'All');
                  }),
                  const SizedBox(width: 8),
                  _buildFilterChip('Pending', selectedStatus == 'Pending', () {
                    setState(() => selectedStatus = 'Pending');
                  }),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'In Progress',
                    selectedStatus == 'In Progress',
                    () {
                      setState(() => selectedStatus = 'In Progress');
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildFilterChip(
                    'Completed',
                    selectedStatus == 'Completed',
                    () {
                      setState(() => selectedStatus = 'Completed');
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Tickets List
          Expanded(
            child: tickets.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tickets found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return _buildTicketCard(ticket);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF5722) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(MaintenanceModel ticket) {
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
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Navigate to detail page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdminDetailMaintenancePage(ticket: ticket),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Ticket ID
                    Text(
                      "Ticket #${ticket.id}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: getStatusColor(
                              getTextStatus(ticket.status ?? 'Pending'),
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            getTextStatus(ticket.status ?? 'Pending'),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: getStatusColor(ticket.status ?? 'Pending'),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tenant Info
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ticket.tenant?.fullName ?? 'Unknown Tenant',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.room_outlined,
                      size: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Kamar ${ticket.room?.id ?? 'Unknown'}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Category & Date
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${ticket.createdAt.day}/${ticket.createdAt.month}/${ticket.createdAt.year}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  ticket.description ?? 'Deskripsi tidak tersedia',
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Status
              ],
            ),
          ),
        ),
      ),
    );
  }
}
