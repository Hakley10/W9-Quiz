// lib/main.dart
import 'package:flutter/material.dart';
import 'ui/screens/screen_manager.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Quiz',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ScreenManager(),
    );
  }
}
