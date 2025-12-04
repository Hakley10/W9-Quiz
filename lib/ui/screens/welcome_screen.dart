import 'package:flutter/material.dart';
import '../../data/quiz_data.dart';
import '../../model/quiz.dart';
import 'question_screen.dart';
import 'history_screen.dart';
import '../widgets/app_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late Quiz quiz;

  @override
  void initState() {
    super.initState();
    quiz = mockQuiz;
  }

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuestionScreen(quiz: quiz),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            AppButton(
              text: "History",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoryScreen(history: quiz.submissions),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}