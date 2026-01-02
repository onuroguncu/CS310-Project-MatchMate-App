import 'package:flutter/material.dart';
import '../main.dart'; // mainWrapperKey'e erişmek için
import 'home_screen.dart';
import 'events_screen.dart';
import 'calendar_screen.dart';
import 'gift_ideas_screen.dart';
import 'settings_screen.dart';

class MainWrapper extends StatefulWidget {
  // HATA BURADAYDI: const kelimesini kaldırdık
  MainWrapper({Key? key}) : super(key: mainWrapperKey);

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  // Dışarıdan (Home Screen'den) çağrılacak fonksiyon
  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    EventsScreen(),
    const CalendarScreen(),
    GiftIdeasScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack sayfaların durumunu (scroll vb.) korur
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: setIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0F172A),
        selectedItemColor: const Color(0xFFFB923C),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard_rounded), label: 'Gifts'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}