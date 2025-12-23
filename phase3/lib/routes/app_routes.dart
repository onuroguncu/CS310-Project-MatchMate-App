import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/home_screen.dart';
import '../screens/events_screen.dart';
import '../screens/add_event_screen.dart';
import '../screens/performance_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/gift_ideas_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String events = '/events';
  static const String addEvent = '/add-event';
  static const String performance = '/performance';
  static const String settings = '/settings';
  static const String giftIdeas = '/gift-ideas';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    events: (context) => const EventsScreen(),
    addEvent: (context) => const AddEventScreen(),
    performance: (context) => const PerformanceScreen(),
    settings: (context) => const SettingsScreen(),
    giftIdeas: (context) => const GiftIdeasScreen(),
  };
}