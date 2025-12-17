import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../utils/app_text_styles.dart';

class ProfileStep1Screen extends StatefulWidget {
  const ProfileStep1Screen({super.key});

  @override
  State<ProfileStep1Screen> createState() => _ProfileStep1ScreenState();
}

class _ProfileStep1ScreenState extends State<ProfileStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _team = '';

  void _next() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.pushNamed(
      context,
      AppRoutes.profileStep2,
      arguments: {'name': _name, 'team': _team},
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Step 1/2'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width > 600 ? width * 0.2 : 24,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome! ⚽', style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            const Text('Let\'s set up your profile', style: AppTextStyles.body),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Your Name',
                      filled: true,
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Please enter your name'
                        : null,
                    onSaved: (v) => _name = v ?? '',
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Favorite Football Team',
                      filled: true,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'GS', child: Text('Galatasaray')),
                      DropdownMenuItem(value: 'FB', child: Text('Fenerbahçe')),
                      DropdownMenuItem(value: 'BJK', child: Text('Beşiktaş')),
                    ],
                    onChanged: (value) => _team = value ?? '',
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Please select a team' : null,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _next,
                      child: const Text('Next'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your data is stored securely and privately',
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
