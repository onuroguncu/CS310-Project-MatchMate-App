import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Info")),
      body: const Center(child: Text("User Profile Details", style: TextStyle(color: Colors.white))),
    );
  }
}