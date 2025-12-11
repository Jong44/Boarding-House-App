import 'package:flutter/widgets.dart';

class AdminStatCardListTenants extends StatelessWidget {
  final String value;
  final String label;
  final Color bgColor;
  final Color textColor;

  const AdminStatCardListTenants({
    super.key,
    required this.label,
    required this.value,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 22, color: Color(0xFF2D2D2D)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
