import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/profile_step1_screen.dart';
import '../screens/profile_step2_screen.dart';
import '../screens/home_screen.dart';
import '../screens/events_screen.dart';
import '../screens/fixtures_screen.dart';
import '../screens/performance_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/create_event_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/reminders_screen.dart';
import '../screens/settings_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String profileStep1 = '/profile-step1';
  static const String profileStep2 = '/profile-step2';
  static const String home = '/home';
  static const String events = '/events';
  static const String fixtures = '/fixtures';
  static const String performance = '/performance';
  static const String dashboard = '/dashboard';
  static const String createEvent = '/create-event';
  static const String calendar = '/calendar';
  static const String reminders = '/reminders';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    profileStep1: (context) => const ProfileStep1Screen(),
    profileStep2: (context) => const ProfileStep2Screen(),
    home: (context) => const HomeScreen(),
    events: (context) => const EventsScreen(),
    fixtures: (context) => const FixturesScreen(),
    performance: (context) => const PerformanceScreen(),
    dashboard: (context) => const DashboardScreen(),
    createEvent: (context) => const CreateEventScreen(),
    calendar: (context) => const CalendarScreen(),
    reminders: (context) => const RemindersScreen(),
    settings: (context) => const SettingsScreen(),
  };
}
