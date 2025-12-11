import 'package:boarding_house_app/modules/owner/features/service/property_revenue_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PropertyRevenueChart extends StatefulWidget {
  final Map<String, dynamic> property;

  const PropertyRevenueChart({Key? key, required this.property})
    : super(key: key);

  @override
  State<PropertyRevenueChart> createState() => _PropertyRevenueChartState();
}

class _PropertyRevenueChartState extends State<PropertyRevenueChart> {
  final PropertyRevenueService _service = PropertyRevenueService();
  List<PropertyRevenueModel> _revenueData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final propertyId = widget.property['id'];
    final data = await _service.getRevenueForProperty(propertyId);

    if (mounted) {
      setState(() {
        _revenueData = data;
        _isLoading = false;
      });
    }
  }

  String _formatLabel(double value) {
    if (value >= 1000000) {
      final jt = value / 1000000;
      return jt == jt.toInt()
          ? '${jt.toInt()}jt'
          : '${jt.toStringAsFixed(1)}jt';
    } else if (value >= 1000) {
      final rb = value / 1000;
      return '${rb.toInt()}rb';
    }
    return value.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B35).withAlpha(26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.show_chart_rounded,
                  color: Color(0xFFFF6B35),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Grafik Pendapatan Properti',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '12 Bulan Terakhir',
            style: TextStyle(fontSize: 13, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 24),
          if (_isLoading)
            const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_revenueData.isEmpty)
            const SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'Belum ada data pendapatan',
                  style: TextStyle(color: Color(0xFF757575)),
                ),
              ),
            )
          else
            SizedBox(height: 200, child: _buildChart()),
        ],
      ),
    );
  }

  Widget _buildChart() {
    final maxRevenue = _revenueData.isEmpty
        ? 1.0
        : _revenueData.map((e) => e.revenue).reduce((a, b) => a > b ? a : b);

    final maxY = maxRevenue <= 0 ? 1000000.0 : (maxRevenue * 1.2);
    final interval = maxY / 5;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: interval,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: const Color(0xFFE0E0E0), strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 45,
              interval: interval,
              getTitlesWidget: (value, meta) {
                return Text(
                  _formatLabel(value),
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 10,
                  ),
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
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= _revenueData.length || index < 0) {
                  return const Text('');
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _revenueData[index].month,
                    style: const TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (_revenueData.length - 1).toDouble(),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: _revenueData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.revenue);
            }).toList(),
            isCurved: true,
            color: const Color(0xFFFF6B35),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFFF6B35).withAlpha(26),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => const Color(0xFFFF6B35),
            tooltipBorder: const BorderSide(color: Colors.transparent),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  'Rp ${_formatLabel(spot.y)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
