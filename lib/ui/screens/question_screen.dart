import 'package:flutter/material.dart';
import '../../model/quiz_engine.dart';
import '../widgets/question_card.dart';
import '../widgets/app_button.dart';
import '../../model/quiz.dart';

class QuestionScreen extends StatefulWidget {
  final QuizEngine quizEngine;
  final Function(PlayerSubmission) onFinish;
  final VoidCallback onBack;

  const QuestionScreen({
    super.key,
    required this.quizEngine,
    required this.onFinish,
    required this.onBack,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final progress = (widget.quizEngine.currentQuestionIndex + 1) /
        widget.quizEngine.totalQuestions;

    return Scaffold(
      backgroundColor: const Color(0xFF1EA5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBack,
        ),
        title: Text(
          "Question ${widget.quizEngine.currentQuestionIndex + 1} of ${widget.quizEngine.totalQuestions}",
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
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 2, 239, 37)),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),

            QuestionCard(
              question: widget.quizEngine.currentQuestion,
              selectedIndex: widget.quizEngine.selectedChoiceIndex,
              onTap: (index) {
                final choiceId = widget.quizEngine.currentQuestion.choices[index].id;
                setState(() {
                  widget.quizEngine.selectAnswer(choiceId);
                });
              },
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous button
                if (widget.quizEngine.currentQuestionIndex > 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: AppButton(
                      text: "Previous",
                      onPressed: () {
                        setState(() {
                          widget.quizEngine.previousQuestion();
                        });
                      },
                    ),
                  ),

                // Next/Submit button
                AppButton(
                  text: widget.quizEngine.currentQuestionIndex ==
                          widget.quizEngine.totalQuestions - 1
                      ? "Submit"
                      : "Next",
                  onPressed: () {
                    if (!widget.quizEngine.hasAnsweredCurrentQuestion) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select an answer before proceeding'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }

                    if (widget.quizEngine.currentQuestionIndex ==
                        widget.quizEngine.totalQuestions - 1) {
                      // Submit quiz
                      widget.onFinish(widget.quizEngine.submitQuiz());
                    } else {
                      setState(() {
                        widget.quizEngine.nextQuestion();
                      });
                    }
                  },
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