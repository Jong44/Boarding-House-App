import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  final Map<String, dynamic> ticket;

  const TicketDetailPage({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ticket Detail',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1A1A1A)),
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    SizedBox(width: 12),
                    Text('Delete Ticket', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket['id'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: statusBgColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          workStatus,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: verifyColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: verifyColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          verificationStatus,
                          style: TextStyle(
                            color: verifyColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.room_outlined,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ticket['room'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Created: ${ticket['createdDate']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Description & Attachments
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    ticket['description'],
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF1A1A1A),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Attachments',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(
                      2,
                      (index) => Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://picsum.photos/200?random=$index',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Timeline
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Timeline',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildTimelineItem(
                    'Ticket Created',
                    '10 Jan 2025, 09:00',
                    true,
                  ),
                  if (verificationStatus != 'Pending') ...[
                    _buildTimelineItem(
                      verificationStatus == 'Verified'
                          ? 'Verified by Admin'
                          : 'Rejected by Admin',
                      '11 Jan 2025, 10:30',
                      true,
                    ),
                  ],
                  if (workStatus == 'In Progress' ||
                      workStatus == 'Completed') ...[
                    _buildTimelineItem(
                      'Maintenance Team Assigned',
                      '11 Jan 2025, 11:00',
                      true,
                    ),
                    _buildTimelineItem(
                      'In Progress',
                      '12 Jan 2025, 08:00',
                      true,
                    ),
                  ],
                  if (workStatus == 'Completed') ...[
                    _buildTimelineItem(
                      'Completed',
                      ticket['completionDate'] ?? '14 Jan 2025, 16:00',
                      false,
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Status Box
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatusRow('Work Status', workStatus, statusColor),
                  const SizedBox(height: 12),
                  _buildStatusRow(
                    'Verification Status',
                    verificationStatus,
                    verifyColor,
                  ),
                  if (ticket['completionDate'] != null) ...[
                    const SizedBox(height: 12),
                    _buildStatusRow(
                      'Completion Date',
                      ticket['completionDate'],
                      Colors.grey[800]!,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildStatusRow(
                    'Assigned Staff',
                    'Teknisi A',
                    Colors.grey[800]!,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, bool hasNext) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFFFF6B2C),
                shape: BoxShape.circle,
              ),
            ),
            if (hasNext)
              Container(width: 2, height: 40, color: Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Ticket',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this ticket? This action cannot be undone.',
          style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF757575)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ticket deleted successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
