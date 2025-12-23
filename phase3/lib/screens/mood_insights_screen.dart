import 'package:flutter/material.dart';

class MoodInsightsScreen extends StatelessWidget {
  const MoodInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("Mood Insights"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF7A45), Color(0xFFFF5252)]),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Column(
                children: [
                  Text("Relationship Sync", style: TextStyle(color: Colors.white, fontSize: 18)),
                  SizedBox(height: 10),
                  Text("%94", style: TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold)),
                  Text("Great Momentum!", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _bar("Mon", 0.4), _bar("Tue", 0.7), _bar("Wed", 0.9),
                  _bar("Thu", 0.6), _bar("Fri", 0.8), _bar("Sat", 1.0), _bar("Sun", 0.9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(String day, double val) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(width: 12, height: 120 * val, decoration: BoxDecoration(color: const Color(0xFFFF7A45), borderRadius: BorderRadius.circular(10))),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}