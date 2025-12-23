import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../utils/app_text_styles.dart';

class ProfileStep2Screen extends StatefulWidget {
  const ProfileStep2Screen({super.key});

  @override
  State<ProfileStep2Screen> createState() => _ProfileStep2ScreenState();
}

class _ProfileStep2ScreenState extends State<ProfileStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  String _partnerName = '';
  String _birthday = '';
  String _favoriteFlower = '';

  void _finish() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Step 2/2'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width > 600 ? width * 0.2 : 24,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Partner Details 💖', style: AppTextStyles.heading1),
            const SizedBox(height: 8),
            Text(
              'Help us personalize your experience, ${args?['name'] ?? ''}',
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Partner\'s Name',
                      filled: true,
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'Please enter partner\'s name'
                        : null,
                    onSaved: (v) => _partnerName = v ?? '',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Birthday (dd.mm.yyyy)',
                      filled: true,
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Please enter birthday' : null,
                    onSaved: (v) => _birthday = v ?? '',
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Favorite Flower (optional)',
                      filled: true,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'rose', child: Text('Rose')),
                      DropdownMenuItem(value: 'tulip', child: Text('Tulip')),
                      DropdownMenuItem(value: 'orchid', child: Text('Orchid')),
                    ],
                    onChanged: (value) => _favoriteFlower = value ?? '',
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _finish,
                      child: const Text('Get Started'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'All information is encrypted and kept private',
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
