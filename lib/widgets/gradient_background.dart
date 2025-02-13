import 'package:flutter/material.dart';

BoxDecoration getGradientBackground(bool isResting) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isResting
          ? [Color(0xFFFFE0B2), Color(0xFFFFCC80)] // Light orange to dark orange gradient
          : [Color(0xFFB3E5FC), Color(0xFF81D4FA)], // Light blue to dark blue gradient
    ),
  );
}