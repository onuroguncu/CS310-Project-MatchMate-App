import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF121212);
  static const Color cardBg = Color(0xFF1E1E1E);
  static const Color primary = Color(0xFFFF7A45); // Turuncu tonu
  static const Color secondary = Color(0xFFFF5252); // Kırmızı tonu
  static const Color textGrey = Colors.grey;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}