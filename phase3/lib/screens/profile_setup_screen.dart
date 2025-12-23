import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/app_colors.dart';
import '../routes/app_routes.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _position = 'Midfielder';

  Future<void> _saveProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'displayName': _nameController.text,
        'age': int.parse(_ageController.text),
        'position': _position,
      });
      if (mounted) {
        // CORRECT TRANSITION: Profile done, go to Home
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Complete Your Profile", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Full Name")),
            TextField(controller: _ageController, decoration: const InputDecoration(labelText: "Age")),
            DropdownButton<String>(
              value: _position,
              isExpanded: true,
              items: ['Goalkeeper', 'Defender', 'Midfielder', 'Forward']
                  .map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (val) => setState(() => _position = val!),
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: _saveProfile, child: const Text("FINISH")),
          ],
        ),
      ),
    );
  }
}