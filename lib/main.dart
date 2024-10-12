import 'package:fashion_flow/core/themes/theme.dart';
import 'package:fashion_flow/features/onboard/presentation/pages/onboard_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightThemeMode,
      home: const OnboardPage(),
    );
  }
}
