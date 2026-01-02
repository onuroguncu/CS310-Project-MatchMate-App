import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class MainBottomNav extends StatelessWidget {
  final int currentIndex;
  const MainBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF1A1A1A),
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == currentIndex) return;
        String route;
        switch (index) {
          case 0: route = AppRoutes.home; break;
          case 1: route = AppRoutes.events; break;
          case 2: route = AppRoutes.calendar; break;
          case 3: route = AppRoutes.settings; break;
          default: route = AppRoutes.home;
        }
        Navigator.pushReplacementNamed(context, route);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Events'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}