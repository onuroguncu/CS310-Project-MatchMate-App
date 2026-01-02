import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    User? user = FirebaseAuth.instance.currentUser;
    if (mounted) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF0F172A)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFFFB923C).withOpacity(0.1), shape: BoxShape.circle),
              child: const Icon(Icons.favorite_rounded, size: 80, color: Color(0xFFFB923C)),
            ),
            const SizedBox(height: 20),
            const Text("MatchMate", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
            const SizedBox(height: 10),
            const Text("Every moment counts", style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 50),
            const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFB923C))),
          ],
        ),
      ),
    );
  }
}