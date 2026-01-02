import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import '../main.dart'; // mainWrapperKey için

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService fs = FirestoreService();
    const Color primaryOrange = Color(0xFFFB923C);

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: fs.getEvents(),
        builder: (context, eventSnapshot) {
          String nextEventTitle = "No Upcoming Event";
          String daysLeftStr = "0";
          double progressValue = 0.1;

          if (eventSnapshot.hasData && eventSnapshot.data!.docs.isNotEmpty) {
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            var events = eventSnapshot.data!.docs.toList();
            events.sort((a, b) => (a['date'] as Timestamp).compareTo(b['date'] as Timestamp));

            var upcoming = events.where((doc) {
              DateTime d = (doc['date'] as Timestamp).toDate();
              return d.isAfter(today) || d.isAtSameMomentAs(today);
            }).toList();

            if (upcoming.isNotEmpty) {
              var nextEvent = upcoming.first;
              DateTime eventDate = (nextEvent['date'] as Timestamp).toDate();
              int days = eventDate.difference(today).inDays;
              nextEventTitle = nextEvent['title'];
              daysLeftStr = days == 0 ? "Today" : days.toString();
              progressValue = ((30 - days) / 30).clamp(0.1, 1.0);
            }
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text("MatchMate", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),

                  // --- Üst Progress Kartı ---
                  _buildTopCard(nextEventTitle, daysLeftStr, progressValue, primaryOrange),

                  const SizedBox(height: 30),

                  // --- Navigasyon Grid ---
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _buildMenuCard("Gift Ideas", Icons.lightbulb_outline, const Color(0xFF818CF8), 3),
                        _buildMenuCard("Calendar", Icons.calendar_month, const Color(0xFFF472B6), 2),
                        _buildMenuCard("Events", Icons.favorite_border, primaryOrange, 1),
                        _buildMenuCard("Personal Info", Icons.person_outline, const Color(0xFF34D399), 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopCard(String title, String days, double progress, Color orange) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF1E293B), orange], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Next Event", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(days, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.black.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, Color color, int index) {
    return GestureDetector(
      onTap: () => mainWrapperKey.currentState?.setIndex(index),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 35),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}