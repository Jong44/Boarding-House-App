import 'package:boarding_house_app/modules/admin/views/maintenance/pages/admin_detail_maintenance_page.dart';
import 'package:flutter/material.dart';

// Model untuk Maintenance Ticket
class MaintenanceTicket {
  final String ticketId;
  final String tenantName;
  final String room;
  final DateTime dateSubmitted;
  final String category;
  final String priority;
  final String status;
  final String description;

  MaintenanceTicket({
    required this.ticketId,
    required this.tenantName,
    required this.room,
    required this.dateSubmitted,
    required this.category,
    required this.priority,
    required this.status,
    required this.description,
  });
}

class AdminListMaintenancePage extends StatefulWidget {
  const AdminListMaintenancePage({Key? key}) : super(key: key);

  @override
  State<AdminListMaintenancePage> createState() =>
      _AdminListMaintenancePageState();
}

class _AdminListMaintenancePageState extends State<AdminListMaintenancePage> {
  String selectedStatus = 'All';
  String selectedPriority = 'All';
  String searchQuery = '';

  // Dummy data
  final List<MaintenanceTicket> tickets = [
    MaintenanceTicket(
      ticketId: 'MT-001',
      tenantName: 'John Doe',
      room: 'Room 101',
      dateSubmitted: DateTime(2025, 1, 15),
      category: 'AC',
      priority: 'High',
      status: 'Pending',
      description: 'AC not cooling properly',
    ),
    MaintenanceTicket(
      ticketId: 'MT-002',
      tenantName: 'Jane Smith',
      room: 'Room 205',
      dateSubmitted: DateTime(2025, 1, 14),
      category: 'Listrik',
      priority: 'Medium',
      status: 'In Progress',
      description: 'Light bulb not working',
    ),
    MaintenanceTicket(
      ticketId: 'MT-003',
      tenantName: 'Robert Johnson',
      room: 'Room 302',
      dateSubmitted: DateTime(2025, 1, 13),
      category: 'Air',
      priority: 'High',
      status: 'Pending',
      description: 'Water leak in bathroom',
    ),
    MaintenanceTicket(
      ticketId: 'MT-004',
      tenantName: 'Emily Davis',
      room: 'Room 108',
      dateSubmitted: DateTime(2025, 1, 12),
      category: 'WiFi',
      priority: 'Low',
      status: 'Completed',
      description: 'Slow internet connection',
    ),
    MaintenanceTicket(
      ticketId: 'MT-005',
      tenantName: 'Michael Brown',
      room: 'Room 410',
      dateSubmitted: DateTime(2025, 1, 11),
      category: 'Furniture',
      priority: 'Medium',
      status: 'In Progress',
      description: 'Broken desk drawer',
    ),
  ];

  List<MaintenanceTicket> get filteredTickets {
    return tickets.where((ticket) {
      bool matchesStatus =
          selectedStatus == 'All' || ticket.status == selectedStatus;
      bool matchesPriority =
          selectedPriority == 'All' || ticket.priority == selectedPriority;
      bool matchesSearch =
          searchQuery.isEmpty ||
          ticket.tenantName.toLowerCase().contains(searchQuery.toLowerCase()) ||
          ticket.room.toLowerCase().contains(searchQuery.toLowerCase()) ||
          ticket.ticketId.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesStatus && matchesPriority && matchesSearch;
    }).toList();
  }

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
      case 'Pending':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            child: filteredTickets.isEmpty
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
                    itemCount: filteredTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = filteredTickets[index];
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

  Widget _buildTicketCard(MaintenanceTicket ticket) {
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
                      ticket.ticketId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Priority Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: getPriorityColor(
                          ticket.priority,
                        ).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flag,
                            size: 14,
                            color: getPriorityColor(ticket.priority),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ticket.priority,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: getPriorityColor(ticket.priority),
                            ),
                          ),
                        ],
                      ),
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
                      ticket.tenantName,
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
                      ticket.room,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Category & Date
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5722).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ticket.category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFFFF5722),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${ticket.dateSubmitted.day}/${ticket.dateSubmitted.month}/${ticket.dateSubmitted.year}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  ticket.description,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: getStatusColor(ticket.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        ticket.status,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: getStatusColor(ticket.status),
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
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter Options',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Priority',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: ['All', 'High', 'Medium', 'Low'].map((priority) {
                      return ChoiceChip(
                        label: Text(priority),
                        selected: selectedPriority == priority,
                        onSelected: (selected) {
                          setModalState(() {
                            setState(() {
                              selectedPriority = priority;
                            });
                          });
                        },
                        selectedColor: const Color(0xFFFF5722),
                        labelStyle: TextStyle(
                          color: selectedPriority == priority
                              ? Colors.white
                              : Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Apply Filters',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
