import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'utils/app_colors.dart';
import 'utils/app_text_styles.dart';

void main() {
  runApp(const MatchMateApp());
}

class MatchMateApp extends StatelessWidget {
  const MatchMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatchMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        textTheme: TextTheme(bodyMedium: AppTextStyles.body),
      ),
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
