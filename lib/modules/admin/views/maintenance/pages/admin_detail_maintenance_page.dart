import 'package:boarding_house_app/modules/admin/views/maintenance/pages/admin_list_maintenance_page.dart';
import 'package:flutter/material.dart';

// Detail Page
class AdminDetailMaintenancePage extends StatefulWidget {
  final MaintenanceTicket ticket;

  const AdminDetailMaintenancePage({Key? key, required this.ticket})
    : super(key: key);

  @override
  State<AdminDetailMaintenancePage> createState() =>
      _AdminDetailMaintenancePageState();
}

class _AdminDetailMaintenancePageState
    extends State<AdminDetailMaintenancePage> {
  String currentStatus = '';
  String assignedTechnician = 'Not Assigned';
  final TextEditingController noteController = TextEditingController();
  List<String> activityLogs = [];

  @override
  void initState() {
    super.initState();
    currentStatus = widget.ticket.status;
    // Dummy activity logs
    activityLogs = [
      'Ticket created - ${_formatDate(widget.ticket.dateSubmitted)}',
      'Waiting for technician assignment',
    ];
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.ticket.ticketId,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              _showOptionsMenu();
            },
          ),
        ],
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
                  // Priority
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Priority',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: getPriorityColor(
                            widget.ticket.priority,
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.flag,
                              size: 16,
                              color: getPriorityColor(widget.ticket.priority),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.ticket.priority,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: getPriorityColor(widget.ticket.priority),
                              ),
                            ),
                          ],
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
              title: 'Tenant Information',
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.person_outline,
                    'Name',
                    widget.ticket.tenantName,
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    Icons.room_outlined,
                    'Room',
                    widget.ticket.room,
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
              title: 'Ticket Details',
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.category_outlined,
                    'Category',
                    widget.ticket.category,
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    Icons.calendar_today_outlined,
                    'Submitted',
                    _formatDate(widget.ticket.dateSubmitted),
                  ),
                  const Divider(height: 24),
                  _buildInfoRow(
                    Icons.description_outlined,
                    'Description',
                    widget.ticket.description,
                    isLong: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Photos (if any)
            _buildSectionCard(
              title: 'Photos',
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 40,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No photos uploaded',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Assigned Technician
            _buildSectionCard(
              title: 'Assigned Technician',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(
                          0xFFFF5722,
                        ).withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          color: Color(0xFFFF5722),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            assignedTechnician,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            assignedTechnician == 'Not Assigned'
                                ? 'Tap to assign'
                                : 'Technician',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: Color(0xFFFF5722),
                    ),
                    onPressed: () {
                      _showAssignTechnicianDialog();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Internal Notes
            _buildSectionCard(
              title: 'Internal Notes',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Add internal notes...',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (noteController.text.isNotEmpty) {
                          setState(() {
                            activityLogs.add(
                              'Note added: ${noteController.text}',
                            );
                            noteController.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Note added successfully'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Add Note'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Activity Log
            _buildSectionCard(
              title: 'Activity Log',
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activityLogs.length,
                separatorBuilder: (context, index) => const Divider(height: 16),
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 6),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF5722),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          activityLogs[index],
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 100),
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
                  'Mark Complete',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
              _buildStatusOption('Pending'),
              _buildStatusOption('In Progress'),
              _buildStatusOption('Completed'),
              _buildStatusOption('Cancelled'),
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
      onTap: () {
        setState(() {
          currentStatus = status;
          activityLogs.add(
            'Status changed to $status - ${_formatDate(DateTime.now())}',
          );
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Status updated to $status')));
      },
    );
  }

  void _showAssignTechnicianDialog() {
    final technicians = [
      'John Smith',
      'Michael Brown',
      'David Wilson',
      'Sarah Johnson',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Assign Technician'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: technicians.map((tech) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFFF5722).withOpacity(0.1),
                  child: Text(
                    tech[0],
                    style: const TextStyle(color: Color(0xFFFF5722)),
                  ),
                ),
                title: Text(tech),
                onTap: () {
                  setState(() {
                    assignedTechnician = tech;
                    activityLogs.add(
                      'Assigned to $tech - ${_formatDate(DateTime.now())}',
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Assigned to $tech')));
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _markAsCompleted() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Mark as Completed'),
          content: const Text(
            'Are you sure you want to mark this ticket as completed?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentStatus = 'Completed';
                  activityLogs.add(
                    'Ticket completed - ${_formatDate(DateTime.now())}',
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ticket marked as completed')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722),
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit, color: Color(0xFFFF5722)),
                title: const Text('Edit Ticket'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Edit functionality coming soon'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete Ticket',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Ticket'),
          content: const Text(
            'Are you sure you want to delete this ticket? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context); // Back to list
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Ticket deleted')));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}
