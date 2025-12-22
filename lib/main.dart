import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';
import 'utils/app_colors.dart';
import 'utils/app_text_styles.dart';

// Bu importlar bir sonraki adımlarda eklenecek:
// import 'providers/auth_provider.dart';
// import 'providers/match_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 

  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => AuthProvider()),
        // ChangeNotifierProvider(create: (_) => MatchProvider()),
      ],
      child: const MatchMateApp(),
    ),
  );
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
