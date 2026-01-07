import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const HealthyHabitApp());
}

class HealthyHabitApp extends StatelessWidget {
  const HealthyHabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthyHabit',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}