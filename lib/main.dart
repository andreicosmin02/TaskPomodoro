import 'package:flutter/material.dart';
import 'screens/starting_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskPomodoro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blueAccent,
          secondary: Colors.redAccent,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontSize: 32,
            color: Colors.black,
          ),
        ),
      ),
      home: const StartingPage(),
    );
  }
}