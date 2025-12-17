import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/main_bottom_nav.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    return Scaffold(
      bottomNavigationBar: const MainBottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NextEventCard(isWide: isWide),
              const SizedBox(height: 24),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: isWide ? 4 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _FeatureTile(
                    icon: Icons.card_giftcard,
                    title: 'Gift Ideas',
                    subtitle: '12 suggestions',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.performance);
                    },
                  ),
                  _FeatureTile(
                    icon: Icons.mood,
                    title: 'Mood Insight',
                    subtitle: 'High energy',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.reminders);
                    },
                  ),
                  _FeatureTile(
                    icon: Icons.event,
                    title: 'Events',
                    subtitle: '3 upcoming',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.events);
                    },
                  ),
                  _FeatureTile(
                    icon: Icons.bar_chart,
                    title: 'Statistics',
                    subtitle: 'View insights',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.dashboard);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextEventCard extends StatelessWidget {
  final bool isWide;

  const _NextEventCard({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6A3D), Color(0xFFFFC857)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            flex: isWide ? 3 : 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Next Event',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Anniversary',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Preparation Progress',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 6),
                LinearProgressIndicator(
                  value: 0.75,
                  color: Colors.white,
                  backgroundColor: Colors.white38,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                '2 Days',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('left', style: AppTextStyles.body),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28),
              const Spacer(),
              Text(title, style: AppTextStyles.heading2),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.body),
            ],
          ),
        ),
      ),
    );
  }
}
