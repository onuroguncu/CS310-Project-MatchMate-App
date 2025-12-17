import 'package:flutter/material.dart';
import '../models/gift_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/main_bottom_nav.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final List<GiftModel> _gifts = [
    GiftModel(
      title: 'Winning Goal Assist',
      tier: 'Premium',
      date: 'October 15, 2025',
      price: 45,
    ),
    GiftModel(
      title: 'Championship Bonus',
      tier: 'Elite',
      date: 'September 22, 2025',
      price: 120,
    ),
    GiftModel(
      title: 'Victory Celebration',
      tier: 'Special',
      date: 'August 10, 2025',
      price: 200,
    ),
  ];

  void _removeGift(int index) {
    setState(() {
      _gifts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gifts & Performance')),
      bottomNavigationBar: const MainBottomNav(currentIndex: 2),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _gifts.length,
        itemBuilder: (context, index) {
          final g = _gifts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Card(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Image.network(
                  // network image (gereksinim)
                  'https://images.pexels.com/photos/1028725/pexels-photo-1028725.jpeg',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
                title: Text(g.title, style: AppTextStyles.heading2),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text('${g.tier} · ${g.date}', style: AppTextStyles.body),
                    const SizedBox(height: 4),
                    Text(
                      '\$${g.price.toStringAsFixed(0)}',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.redAccent,
                  onPressed: () => _removeGift(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
