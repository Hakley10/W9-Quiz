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
  List<int?> selectedAnswers = [];

  void selectAnswer(int i) {
    setState(() {
      if (selectedAnswers.length <= currentQuestionIndex) {
        selectedAnswers.add(i);
      } else {
        selectedAnswers[currentQuestionIndex] = i;
      }
    });
  }

  void next() {
    final question = widget.quiz.questions[currentQuestionIndex];
    final selectedIndex = _getSelectedIndex();

    if (selectedIndex != null && question.answers[selectedIndex].isCorrect) {
      if (!_isAnswerAlreadyCounted(currentQuestionIndex)) {
        score++;
      }
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
      });
    }
  }

  void previous() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  int? _getSelectedIndex() {
    return selectedAnswers.length > currentQuestionIndex 
        ? selectedAnswers[currentQuestionIndex] 
        : null;
  }

  bool _isAnswerAlreadyCounted(int questionIndex) {
    return selectedAnswers.length > questionIndex && 
           selectedAnswers[questionIndex] != null &&
           widget.quiz.questions[questionIndex]
               .answers[selectedAnswers[questionIndex]!].isCorrect;
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentQuestionIndex];
    final selectedIndex = _getSelectedIndex();
    final totalQuestions = widget.quiz.questions.length;
    final progress = (currentQuestionIndex + 1) / totalQuestions;

    return Scaffold(
      backgroundColor: const Color(0xFF1EA5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Question ${currentQuestionIndex + 1} of $totalQuestions",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Visual Progress Bar
            Container(
              width: 300,
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
 
                ],
              ),
            ),

            QuestionCard(
              question: question,
              selectedIndex: selectedIndex,
              onTap: selectAnswer,
            ),
            const SizedBox(height: 20),
            
            // Navigation buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous button
                if (currentQuestionIndex > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: AppButton(
                      text: "Previous",
                      onPressed: previous,
                    ),
                  ),
                
                // Next/Submit button
                AppButton(
                  text: currentQuestionIndex == totalQuestions - 1 
                      ? "Submit" 
                      : "Next",
                  onPressed: next,
                ),
              ],
            ),
            const SizedBox(height: 40),
            
  
          ],
        ),
      ),
    );
  }
}