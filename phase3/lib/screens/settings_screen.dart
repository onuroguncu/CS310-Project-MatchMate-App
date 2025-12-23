import 'package:flutter/material.dart';
import '../widgets/main_bottom_nav.dart';
import '../routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notif = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("Settings"), backgroundColor: Colors.transparent),
      bottomNavigationBar: const MainBottomNav(currentIndex: 3), // 'const' kaldırıldı
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle, color: Color(0xFFFF7A45)),
            title: const Text("Account Settings", style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushNamed(context, AppRoutes.performance),
          ),
          SwitchListTile(
            title: const Text("Notifications", style: TextStyle(color: Colors.white)),
            value: notif,
            activeColor: const Color(0xFFFF7A45),
            onChanged: (v) => setState(() => notif = v),
          ),
          const Divider(color: Colors.white10),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
          ),
        ],
      ),
    );
  }
}