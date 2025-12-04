import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import 'welcome_screen.dart';
import '../widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  final Quiz quiz;
  final PlayerSubmission submission;

  const ResultScreen({
    super.key,
    required this.quiz,
    required this.submission,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (submission.score / submission.total * 100).toInt();
    
    return Scaffold(
      backgroundColor: const Color(0xFF1EA5FC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              _getResultEmoji(percentage),
              style: const TextStyle(fontSize: 60),
            ),
            const SizedBox(height: 20),
            
            Text(
              "Quiz Completed!",
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            Text(
              "Score: ${submission.score} / ${submission.total}",
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            Text(
              "$percentage%",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),

            AppButton(
              text: "Restart Quiz",
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  String _getResultEmoji(int percentage) {
    if (percentage >= 90) return "🎉";
    if (percentage >= 70) return "👍";
    if (percentage >= 50) return "😊";
    return "😔";
  }
}