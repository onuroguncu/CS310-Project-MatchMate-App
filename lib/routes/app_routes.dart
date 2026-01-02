import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/main_wrapper.dart';
import '../screens/events_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/gift_ideas_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home'; // Bu aslında MainWrapper'ı açar
  static const String events = '/events';
  static const String calendar = '/calendar';
  static const String gifts = '/gifts';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),

    // HATA BURADAYDI: 'const' ibaresini sildik
    home: (context) => MainWrapper(),

    events: (context) => EventsScreen(),
    calendar: (context) => const CalendarScreen(),
    gifts: (context) => GiftIdeasScreen(),
  };
}