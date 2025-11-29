import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  QuickActions({super.key});

  final actions = [
    {'icon': Icons.receipt_outlined, 'label': 'Invoice\nSaya'},
    {'icon': Icons.build_outlined, 'label': 'Laporan\nMaintenance'},
    {'icon': Icons.history_outlined, 'label': 'Riwayat\nPembayaran'},
    {'icon': Icons.star_outline, 'label': 'Kirim\nFeedback'},
    {'icon': Icons.home_outlined, 'label': 'Detail\nKamar'},
    {'icon': Icons.description_outlined, 'label': 'Detail\nKontrak'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        return Container(
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
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    actions[index]['icon'] as IconData,
                    size: 28,
                    color: const Color(0xFFFF6B2C),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    actions[index]['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
