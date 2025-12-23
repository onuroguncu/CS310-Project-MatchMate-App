import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final days = List.generate(30, (i) => i + 1);

    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text('November 2025', style: AppTextStyles.heading1),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              crossAxisCount: 7,
              children: days
                  .map(
                    (d) => Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: d % 7 == 0
                            ? AppColors.primary
                            : d % 5 == 0
                            ? AppColors.secondary
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          d.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _LegendDot(color: AppColors.secondary, label: 'High'),
                _LegendDot(color: AppColors.accentYellow, label: 'Medium'),
                _LegendDot(color: AppColors.primary, label: 'Low'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 8, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyles.body),
      ],
    );
  }
}
