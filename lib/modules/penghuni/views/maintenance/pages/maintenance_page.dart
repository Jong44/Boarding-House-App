import 'package:boarding_house_app/modules/penghuni/views/maintenance/pages/create_ticket_page.dart';
import 'package:boarding_house_app/modules/penghuni/views/maintenance/pages/detail_ticket_page.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _tickets = [
    {
      'id': 'MT-2025-001',
      'room': 'Room A12',
      'createdDate': '10 Jan 2025',
      'description': 'Lampu kamar mandi mati, perlu diganti segera',
      'workStatus': 'Open',
      'verificationStatus': 'Pending',
      'completionDate': null,
    },
    {
      'id': 'MT-2025-002',
      'room': 'Room A12',
      'createdDate': '5 Jan 2025',
      'description': 'AC tidak dingin, mungkin perlu service',
      'workStatus': 'In Progress',
      'verificationStatus': 'Verified',
      'completionDate': null,
    },
    {
      'id': 'MT-2024-156',
      'room': 'Room A12',
      'createdDate': '20 Dec 2024',
      'description': 'Pintu lemari rusak, engsel lepas',
      'workStatus': 'Completed',
      'verificationStatus': 'Verified',
      'completionDate': '22 Dec 2024',
    },
  ];

  List<Map<String, dynamic>> get _filteredTickets {
    if (_selectedFilter == 'All') return _tickets;
    return _tickets
        .where(
          (ticket) =>
              ticket['workStatus'].replaceAll(' ', '') ==
              _selectedFilter.replaceAll(' ', ''),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Maintenance Tickets',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Laporkan kerusakan atau keluhan terkait kamar & fasilitas kost',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Create New Ticket Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateTicketPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text(
                    'Create New Ticket',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B2C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Open'),
                    const SizedBox(width: 8),
                    _buildFilterChip('In Progress'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Completed'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Ticket List
            Expanded(
              child: _filteredTickets.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inbox_outlined,
                            size: 80,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredTickets.length,
                      itemBuilder: (context, index) {
                        return _buildTicketCard(_filteredTickets[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF6B2C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF757575),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTicketCard(Map<String, dynamic> ticket) {
    final workStatus = ticket['workStatus'];
    Color statusColor;
    Color statusBgColor;

    switch (workStatus) {
      case 'Completed':
        statusColor = const Color(0xFF4CAF50);
        statusBgColor = const Color(0xFF4CAF50).withOpacity(0.1);
        break;
      case 'In Progress':
        statusColor = const Color(0xFFFF9800);
        statusBgColor = const Color(0xFFFF9800).withOpacity(0.1);
        break;
      default:
        statusColor = const Color(0xFFF44336);
        statusBgColor = const Color(0xFFF44336).withOpacity(0.1);
    }

    final verificationStatus = ticket['verificationStatus'];
    Color verifyColor;
    switch (verificationStatus) {
      case 'Verified':
        verifyColor = const Color(0xFF4CAF50);
        break;
      case 'Rejected':
        verifyColor = const Color(0xFFF44336);
        break;
      default:
        verifyColor = const Color(0xFF9E9E9E);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TicketDetailPage(ticket: ticket),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: ID & Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ticket['id'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF757575),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusBgColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            workStatus,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: verifyColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: verifyColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            verificationStatus,
                            style: TextStyle(
                              color: verifyColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  ticket['description'],
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Room & Date
                Row(
                  children: [
                    Icon(
                      Icons.room_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      ticket['room'],
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      ticket['createdDate'],
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),

                // Completion Date (if completed)
                if (ticket['completionDate'] != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 14,
                          color: Color(0xFF4CAF50),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Completed on ${ticket['completionDate']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // View Detail Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TicketDetailPage(ticket: ticket),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFF6B2C),
                      side: const BorderSide(
                        color: Color(0xFFFF6B2C),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'View Detail',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
