import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class AdminReportsPage extends StatefulWidget {
  const AdminReportsPage({Key? key}) : super(key: key);

  @override
  State<AdminReportsPage> createState() => _AdminReportsPageState();
}

class _AdminReportsPageState extends State<AdminReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTimeRange? _selectedDateRange;
  String _selectedStatus = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedDateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFFF5722),
              indicatorWeight: 3,
              labelColor: const Color(0xFFFF5722),
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              tabs: const [
                Tab(text: 'Occupancy'),
                Tab(text: 'Invoice & Payment'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildOccupancyReport(), _buildInvoicePaymentReport()],
      ),
    );
  }

  Widget _buildOccupancyReport() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildOccupancySummaryCards(),
          _buildOccupancyChart(),
          _buildOccupancyPieChart(),
        ],
      ),
    );
  }

  Widget _buildInvoicePaymentReport() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildPaymentSummaryCards(),
          _buildPaymentLineChart(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _selectDateRange,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Color(0xFFFF5722),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _selectedDateRange != null
                        ? '${DateFormat('MMM dd, yyyy').format(_selectedDateRange!.start)} - ${DateFormat('MMM dd, yyyy').format(_selectedDateRange!.end)}'
                        : 'Select Date Range',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedStatus,
            decoration: InputDecoration(
              labelText: 'Status',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            items: ['All', 'Occupied', 'Available', 'Maintenance']
                .map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status)),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedStatus = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedDateRange = DateTimeRange(
                        start: DateTime.now().subtract(
                          const Duration(days: 30),
                        ),
                        end: DateTime.now(),
                      );
                      _selectedStatus = 'All';
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF5722)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: Color(0xFFFF5722)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filter logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOccupancySummaryCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Rooms',
                  '48',
                  Icons.meeting_room,
                  const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Occupied',
                  '36',
                  Icons.person,
                  const Color(0xFFFF5722),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Available',
                  '10',
                  Icons.check_circle,
                  const Color(0xFF2196F3),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Maintenance',
                  '2',
                  Icons.build,
                  const Color(0xFFFFC107),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSummaryCard(
            'Occupancy Rate',
            '75%',
            Icons.trending_up,
            const Color(0xFF9C27B0),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummaryCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Total Invoices',
                  '124',
                  Icons.receipt_long,
                  const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Total Paid',
                  '\$45,280',
                  Icons.check_circle,
                  const Color(0xFF2196F3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Unpaid',
                  '\$8,420',
                  Icons.pending,
                  const Color(0xFFFFC107),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Overdue',
                  '12',
                  Icons.warning,
                  const Color(0xFFF44336),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSummaryCard(
            'Partial Paid',
            '8',
            Icons.incomplete_circle,
            const Color(0xFFFF5722),
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    bool isFullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOccupancyChart() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Monthly Occupancy Trend',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 50,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                        ];
                        return Text(
                          months[value.toInt()],
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                ),
                barGroups: [
                  _buildBarGroup(0, 32),
                  _buildBarGroup(1, 35),
                  _buildBarGroup(2, 30),
                  _buildBarGroup(3, 38),
                  _buildBarGroup(4, 36),
                  _buildBarGroup(5, 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: const Color(0xFFFF5722),
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildOccupancyPieChart() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Room Status Distribution',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          value: 36,
                          title: '75%',
                          color: const Color(0xFFFF5722),
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: 10,
                          title: '21%',
                          color: const Color(0xFF2196F3),
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          value: 2,
                          title: '4%',
                          color: const Color(0xFFFFC107),
                          radius: 50,
                          titleStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem('Occupied', const Color(0xFFFF5722), '36'),
                    const SizedBox(height: 8),
                    _buildLegendItem(
                      'Available',
                      const Color(0xFF2196F3),
                      '10',
                    ),
                    const SizedBox(height: 8),
                    _buildLegendItem(
                      'Maintenance',
                      const Color(0xFFFFC107),
                      '2',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String value) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text('$label ($value)', style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildPaymentLineChart() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Timeline',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                        ];
                        return Text(
                          months[value.toInt()],
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${(value / 1000).toInt()}K',
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 6000),
                      FlSpot(1, 7200),
                      FlSpot(2, 6800),
                      FlSpot(3, 8500),
                      FlSpot(4, 7800),
                      FlSpot(5, 9000),
                    ],
                    isCurved: true,
                    color: const Color(0xFF4CAF50),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                    ),
                  ),
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 1200),
                      FlSpot(1, 1500),
                      FlSpot(2, 1100),
                      FlSpot(3, 1800),
                      FlSpot(4, 1400),
                      FlSpot(5, 1600),
                    ],
                    isCurved: true,
                    color: const Color(0xFFF44336),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFFF44336).withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Paid', const Color(0xFF4CAF50), ''),
              const SizedBox(width: 20),
              _buildLegendItem('Overdue', const Color(0xFFF44336), ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOccupancyTable() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Room Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Color(0xFFFF5722)),
                  onPressed: () {
                    // Export to Excel/PDF
                  },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
              columns: const [
                DataColumn(label: Text('Room No.')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Tenant')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Check-in')),
                DataColumn(label: Text('Next Invoice')),
              ],
              rows: [
                _buildDataRow(
                  'A101',
                  'Occupied',
                  'John Doe',
                  '\$685',
                  '01/15/24',
                  '02/01/24',
                ),
                _buildDataRow('A102', 'Available', '-', '\$685', '-', '-'),
                _buildDataRow(
                  'A103',
                  'Occupied',
                  'Jane Smith',
                  '\$685',
                  '01/10/24',
                  '02/01/24',
                ),
                _buildDataRow('A104', 'Maintenance', '-', '\$685', '-', '-'),
                _buildDataRow(
                  'A105',
                  'Occupied',
                  'Bob Wilson',
                  '\$685',
                  '01/20/24',
                  '02/01/24',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceTable() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Invoice Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Color(0xFFFF5722)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
              columns: const [
                DataColumn(label: Text('Invoice No.')),
                DataColumn(label: Text('Tenant')),
                DataColumn(label: Text('Room')),
                DataColumn(label: Text('Issue Date')),
                DataColumn(label: Text('Due Date')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Paid')),
                DataColumn(label: Text('Status')),
              ],
              rows: [
                _buildInvoiceDataRow(
                  'INV-001',
                  'John Doe',
                  'A101',
                  '01/01/24',
                  '01/15/24',
                  '\$685',
                  '\$685',
                  'Paid',
                  Colors.green,
                ),
                _buildInvoiceDataRow(
                  'INV-002',
                  'Jane Smith',
                  'A103',
                  '01/01/24',
                  '01/15/24',
                  '\$685',
                  '\$0',
                  'Unpaid',
                  Colors.red,
                ),
                _buildInvoiceDataRow(
                  'INV-003',
                  'Bob Wilson',
                  'A105',
                  '01/01/24',
                  '01/15/24',
                  '\$685',
                  '\$400',
                  'Partial',
                  Colors.orange,
                ),
                _buildInvoiceDataRow(
                  'INV-004',
                  'Alice Brown',
                  'A107',
                  '01/01/24',
                  '01/10/24',
                  '\$685',
                  '\$0',
                  'Overdue',
                  Colors.red,
                ),
                _buildInvoiceDataRow(
                  'INV-005',
                  'Mike Davis',
                  'A109',
                  '01/01/24',
                  '01/15/24',
                  '\$685',
                  '\$685',
                  'Paid',
                  Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryTable() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Payment History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: Color(0xFFFF5722)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.grey.shade100),
              columns: const [
                DataColumn(label: Text('Payment ID')),
                DataColumn(label: Text('Invoice No.')),
                DataColumn(label: Text('Tenant')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Method')),
                DataColumn(label: Text('Notes')),
              ],
              rows: [
                _buildPaymentDataRow(
                  'PAY-001',
                  'INV-001',
                  'John Doe',
                  '01/14/24',
                  '\$685',
                  'Bank Transfer',
                  'On time',
                ),
                _buildPaymentDataRow(
                  'PAY-002',
                  'INV-005',
                  'Mike Davis',
                  '01/15/24',
                  '\$685',
                  'Cash',
                  'Paid in full',
                ),
                _buildPaymentDataRow(
                  'PAY-003',
                  'INV-003',
                  'Bob Wilson',
                  '01/16/24',
                  '\$400',
                  'Bank Transfer',
                  'Partial payment',
                ),
                _buildPaymentDataRow(
                  'PAY-004',
                  'INV-006',
                  'Sarah Lee',
                  '01/17/24',
                  '\$685',
                  'Credit Card',
                  'On time',
                ),
                _buildPaymentDataRow(
                  'PAY-005',
                  'INV-008',
                  'Tom Clark',
                  '01/18/24',
                  '\$685',
                  'Bank Transfer',
                  'Paid in full',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    String roomNo,
    String status,
    String tenant,
    String price,
    String checkIn,
    String nextInvoice,
  ) {
    Color statusColor;
    switch (status) {
      case 'Occupied':
        statusColor = Colors.green;
        break;
      case 'Available':
        statusColor = Colors.blue;
        break;
      case 'Maintenance':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }
    return DataRow(
      cells: [
        DataCell(Text(roomNo)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        DataCell(Text(tenant)),
        DataCell(Text(price)),
        DataCell(Text(checkIn)),
        DataCell(Text(nextInvoice)),
      ],
    );
  }

  DataRow _buildInvoiceDataRow(
    String invoiceNo,
    String tenant,
    String room,
    String issueDate,
    String dueDate,
    String total,
    String paid,
    String status,
    Color statusColor,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(invoiceNo)),
        DataCell(Text(tenant)),
        DataCell(Text(room)),
        DataCell(Text(issueDate)),
        DataCell(Text(dueDate)),
        DataCell(Text(total)),
        DataCell(Text(paid)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  DataRow _buildPaymentDataRow(
    String paymentId,
    String invoiceNo,
    String tenant,
    String date,
    String amount,
    String method,
    String notes,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(paymentId)),
        DataCell(Text(invoiceNo)),
        DataCell(Text(tenant)),
        DataCell(Text(date)),
        DataCell(
          Text(amount, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        DataCell(Text(method)),
        DataCell(
          Text(
            notes,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFFFF5722)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }
}
