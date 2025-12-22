import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/main_bottom_nav.dart';
import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings & Analytics')),
      bottomNavigationBar: const MainBottomNav(currentIndex: 3),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Bar Chart Container
            Container(
              width: double.infinity,
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Monthly Activity', style: AppTextStyles.heading2),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _Bar(month: 'Aug', events: 2, gifts: 1),
                        _Bar(month: 'Sep', events: 3, gifts: 2),
                        _Bar(month: 'Oct', events: 4, gifts: 3),
                        _Bar(month: 'Nov', events: 5, gifts: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Charts Row/Column
            Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(child: _DonutCard()),
                SizedBox(width: 16, height: 16),
                Expanded(child: _RadarPlaceholderCard()),
              ],
            ),
            const SizedBox(height: 24),
            // Settings Options
            SwitchListTile(
              title: const Text('Notifications'),
              value: true,
              onChanged: (_) {},
            ),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: true,
              onChanged: (_) {},
            ),
            const SizedBox(height: 32),
            // LOGOUT BUTTON 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false).signOut();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context, 
                      AppRoutes.login, 
                      (route) => false,
                    );
                  }
                },
                child: const Text('LOGOUT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String month;
  final double events;
  final double gifts;

  const _Bar({required this.month, required this.events, required this.gifts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 14,
                height: events * 12,
                color: AppColors.primary,
              ),
              const SizedBox(height: 4),
              Container(
                width: 14,
                height: gifts * 12,
                color: AppColors.accentYellow,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(month, style: AppTextStyles.body),
      ],
    );
  }
}

class _DonutCard extends StatelessWidget {
  const _DonutCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 220,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text('Activity Mix', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.accentYellow,
                            AppColors.secondary,
                            AppColors.primary,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Text(
                      'Events\nvs Gifts',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadarPlaceholderCard extends StatelessWidget {
  const _RadarPlaceholderCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 220,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text('Relationship Radar', style: AppTextStyles.heading2),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Icon(
                  Icons.pentagon_outlined,
                  size: 100,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Communication • Dates • Gifts • Support',
              textAlign: TextAlign.center,
              style: AppTextStyles.body,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
