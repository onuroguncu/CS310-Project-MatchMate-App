import 'package:flutter/material.dart';

class GiftIdeasScreen extends StatelessWidget {
  const GiftIdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> gifts = [
      {'name': 'Diamond Ring', 'price': '\$450', 'icon': '💍'},
      {'name': 'Red Roses', 'price': '\$60', 'icon': '💐'},
      {'name': 'Perfume Set', 'price': '\$120', 'icon': '🧴'},
      {'name': 'Dinner Date', 'price': '\$200', 'icon': '🕯️'},
      {'name': 'Photo Book', 'price': '\$40', 'icon': '📸'},
      {'name': 'Silk Scarf', 'price': '\$85', 'icon': '🧣'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Romantic Gifts"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15
        ),
        itemCount: gifts.length,
        itemBuilder: (context, index) {
          final gift = gifts[index];
          return Container(
            decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(gift['icon']!, style: const TextStyle(fontSize: 40)),
                const SizedBox(height: 10),
                Text(gift['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(gift['price']!, style: const TextStyle(color: Color(0xFFFF7A45))),
              ],
            ),
          );
        },
      ),
    );
  }
}