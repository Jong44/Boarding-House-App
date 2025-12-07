import 'package:boarding_house_app/modules/owner/features/provider/owner_dashboard_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevenueChart extends ConsumerWidget {
  const RevenueChart({Key? key}) : super(key: key);

  // Helper to format currency label (in juta)
  String _formatLabel(double value) {
    if (value >= 1) {
      return '${value.toStringAsFixed(value % 1 == 0 ? 0 : 1)}jt';
    }
    return '${(value * 1000).toInt()}rb';
  }

  // Calculate nice interval for Y axis
  double _calculateInterval(double maxValue) {
    if (maxValue <= 5) return 1;
    if (maxValue <= 10) return 2.5;
    if (maxValue <= 20) return 5;
    if (maxValue <= 50) return 10;
    if (maxValue <= 100) return 25;
    return 50;
  }

  // Round up to nice max value
  double _calculateMaxY(double maxValue) {
    if (maxValue <= 5) return 5;
    if (maxValue <= 10) return 10;
    if (maxValue <= 20) return 20;
    if (maxValue <= 30) return 30;
    if (maxValue <= 50) return 50;
    if (maxValue <= 100) return 100;
    return ((maxValue / 50).ceil() * 50).toDouble();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(ownerDashboardProvider);
    final chartData = dashboardState.revenueChartData ?? [];
    final isLoading = dashboardState.isLoadingRevenueChart;

    // Extract revenue values (in millions for chart display)
    final revenueData = chartData.map((e) => e.revenue / 1000000).toList();
    final months = chartData.map((e) {
      final parts = e.month.split(' ');
      return parts.isNotEmpty ? parts[0] : '';
    }).toList();

    // Calculate max Y for chart - handle empty case
    double rawMax = 10.0;
    if (revenueData.isNotEmpty) {
      rawMax = revenueData.reduce((a, b) => a > b ? a : b);
      if (rawMax <= 0) rawMax = 10.0;
    }

    final maxY = _calculateMaxY(rawMax * 1.1);
    final interval = _calculateInterval(maxY);

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
                'Grafik Pendapatan Bulanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isLoading ? 'Loading...' : '${chartData.length} Bulan Terakhir',
            style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 24),
          if (isLoading)
            const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            )
          else if (chartData.isEmpty)
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
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: interval,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xFFE0E0E0),
                        strokeWidth: 1,
                      );
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
                              fontSize: 11,
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
                          if (index >= months.length || index < 0) {
                            return const Text('');
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              months[index],
                              style: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 11,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: (revenueData.length - 1).toDouble(),
                  minY: 0,
                  maxY: maxY,
                  lineBarsData: [
                    LineChartBarData(
                      spots: revenueData.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value);
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
                      tooltipBorder: const BorderSide(
                        color: Colors.transparent,
                      ),
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          final value = spot.y;
                          final formatted = value >= 1
                              ? 'Rp ${value.toStringAsFixed(1)}jt'
                              : 'Rp ${(value * 1000).toInt()}rb';
                          return LineTooltipItem(
                            formatted,
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
              ),
            ),
        ],
      ),
    );
  }
}
