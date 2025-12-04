import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStartQuiz;
  final VoidCallback onShowHistory;

  const WelcomeScreen({
    super.key,
    required this.onStartQuiz,
    required this.onShowHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1EA5FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/quiz-logo.png', width: 200, height: 200),
            const SizedBox(height: 60),

            AppButton(
              text: "Start Quiz",
              onPressed: onStartQuiz,
            ),

            const SizedBox(height: 20),

            AppButton(
              text: "History",
              onPressed: onShowHistory,
            ),
          ],
        ),
      ),
    );
  }
}