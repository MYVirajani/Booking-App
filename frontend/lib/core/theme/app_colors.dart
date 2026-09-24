import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFF031518);
  static const surface = Color(0xFF051C1F);
  static const accent = Color(0xFFB9F6CA);
  static const accentAlt = Colors.lightGreenAccent;
  static const cardFill = Colors.white; 
  static const textPrimary = Colors.white;
  static const textSecondary = Colors.white54;
  static const textMuted = Colors.white38;
  static const danger = Colors.redAccent;

  static const welcomeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
  );
}