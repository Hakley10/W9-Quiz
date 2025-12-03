import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import 'result_screen.dart';
import '../widgets/question_card.dart';
import '../widgets/app_button.dart';

class QuestionScreen extends StatefulWidget {
  final Quiz quiz;

  const QuestionScreen({super.key, required this.quiz});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedIndex;

  void selectAnswer(int i) {
    setState(() => selectedIndex = i);
  }

  void next() {
    final question = widget.quiz.questions[currentQuestionIndex];

    if (selectedIndex != null && question.answers[selectedIndex!].isCorrect) {
      score++;
    }

    if (currentQuestionIndex == widget.quiz.questions.length - 1) {
      final submission = PlayerSubmission(
        score: score,
        total: widget.quiz.questions.length,
      );

      widget.quiz.addSubmission(submission);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            quiz: widget.quiz,
            submission: submission,
          ),
        ),
      );
    } else {
      setState(() {
        currentQuestionIndex++;
        selectedIndex = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF1EA5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Question ${currentQuestionIndex + 1}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      QuestionCard(
        question: question,
        selectedIndex: selectedIndex,
        onTap: selectAnswer,
      ),
      const SizedBox(height: 20),
      AppButton(text: "Next", onPressed: next),
      const SizedBox(height: 40),
    ],
  ),
),
    );
  }
}
