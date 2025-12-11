import 'package:flutter/material.dart';

class RevenueCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const RevenueCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigasi ke Financial Report')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Pendapatan Bulan Ini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: data['trendData'] > 0
                          ? const Color(0xFF4CAF50).withOpacity(0.1)
                          : data['trendData'] < 0
                          ? const Color(0xFFFF5252).withOpacity(0.1)
                          : const Color(0xFF9E9E9E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        data['trendData'] > 0
                            ? const Icon(
                                Icons.trending_up_rounded,
                                color: Color(0xFF4CAF50),
                                size: 16,
                              )
                            : data['trendData'] < 0
                            ? const Icon(
                                Icons.trending_down_rounded,
                                color: Color(0xFFFF5252),
                                size: 16,
                              )
                            : const Icon(
                                Icons.trending_flat_rounded,
                                color: Color(0xFF9E9E9E),
                                size: 16,
                              ),
                        SizedBox(width: 4),
                        Text(
                          '${data['trendData']}%',
                          style: TextStyle(
                            color: data['trendData'] > 0
                                ? const Color(0xFF4CAF50)
                                : data['trendData'] < 0
                                ? const Color(0xFFFF5252)
                                : const Color(0xFF9E9E9E),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Rp ${data['totalIncome'].toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
