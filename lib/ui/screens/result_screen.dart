import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import '../widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  final Quiz quiz;
  final PlayerSubmission submission;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.quiz,
    required this.submission,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (submission.score / submission.total * 100).toInt();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Summary
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    _getResultEmoji(percentage),
                    style: const TextStyle(fontSize: 60),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Quiz Completed!",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Score: ${submission.score}/${submission.total}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "$percentage%",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            const Divider(),
            const SizedBox(height: 20),
            
            // Questions and Answers
            Text(
              "Review Answers:",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            
            const SizedBox(height: 16),
            
            for (int i = 0; i < quiz.questions.length; i++)
              _buildQuestionResult(i),
            
            const SizedBox(height: 40),
            
            // Restart Quiz Button (goes to welcome screen)
            Center(
              child: SizedBox(
                width: 200,
                child: AppButton(
                  text: "Restart Quiz",
                  onPressed: onRestart,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionResult(int questionIndex) {
    final question = quiz.questions[questionIndex];
    final answer = submission.answers[questionIndex];
    final isCorrect = answer.isCorrect;
    final selectedChoice = question.choices.firstWhere(
      (c) => c.id == answer.selectedChoiceId,
    );
    final correctChoice = question.choices.firstWhere((c) => c.isCorrect);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question Header
        Text(
          "Question ${questionIndex + 1}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Question Text
        Text(
          question.text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            height: 1.4,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Your Answer
        _buildAnswerBox(
          label: "Your Answer:",
          answer: selectedChoice.text,
          isCorrect: isCorrect,
          isUserAnswer: true,
        ),
        
        // Correct Answer (if wrong)
        if (!isCorrect) ...[
          const SizedBox(height: 12),
          _buildAnswerBox(
            label: "Correct Answer:",
            answer: correctChoice.text,
            isCorrect: true,
            isUserAnswer: false,
          ),
        ],
        
        const SizedBox(height: 24),
        if (questionIndex < quiz.questions.length - 1)
          const Divider(height: 1, color: Colors.grey),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildAnswerBox({
    required String label,
    required String answer,
    required bool isCorrect,
    required bool isUserAnswer,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isUserAnswer 
                ? (isCorrect ? Colors.green[800] : Colors.red[800])
                : Colors.green[800],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUserAnswer
                ? (isCorrect ? Colors.green[50] : Colors.red[50])
                : Colors.green[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isUserAnswer
                  ? (isCorrect ? Colors.green : Colors.red)
                  : Colors.green,
            ),
          ),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 16,
              color: isUserAnswer
                  ? (isCorrect ? Colors.green[900] : Colors.red[900])
                  : Colors.green[900],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _getResultEmoji(int percentage) {
    if (percentage >= 90) return "🎉";
    if (percentage >= 70) return "👍";
    if (percentage >= 50) return "😊";
    return "😔";
  }
}