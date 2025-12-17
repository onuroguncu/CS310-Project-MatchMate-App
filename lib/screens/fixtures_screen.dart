import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class FixturesScreen extends StatelessWidget {
  const FixturesScreen({super.key});

  List<EventModel> _fixtures() => [
    EventModel(
      title: 'Championship Final',
      subtitle: 'Premium seats booked',
      date: 'November 10, 2025 · 7:00 PM',
      daysLeft: '2 days',
    ),
    EventModel(
      title: 'Derby Match',
      subtitle: 'VIP tickets secured',
      date: 'December 5, 2025 · 7:00 PM',
      daysLeft: '27 days',
    ),
    EventModel(
      title: 'Away Game Weekend',
      subtitle: 'All day',
      date: 'December 20, 2025 · All Day',
      daysLeft: '42 days',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final fixtures = _fixtures();
    return Scaffold(
      appBar: AppBar(title: const Text('Fixtures')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fixtures.length,
        itemBuilder: (context, index) {
          final f = fixtures[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Card(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(f.title, style: AppTextStyles.heading2),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(f.date, style: AppTextStyles.body),
                    const SizedBox(height: 4),
                    Text(f.subtitle, style: AppTextStyles.body),
                  ],
                ),
                trailing: Text(
                  f.daysLeft,
                  style: const TextStyle(
                    color: AppColors.accentYellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
