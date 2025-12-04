import 'package:flutter/material.dart';
import '../../model/quiz.dart';

class ResultItem extends StatelessWidget {
  final PlayerSubmission submission;
  final Quiz quiz;

  const ResultItem({
    super.key,
    required this.submission,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Score: ${submission.score}/${submission.total} - ${_getPercentage()}%",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(_formatDate(submission.timestamp)),
      children: submission.answers.map((answer) {
        final question = quiz.questions.firstWhere(
          (q) => q.id == answer.questionId,
        );
        final selectedChoice = question.choices.firstWhere(
          (c) => c.id == answer.selectedChoiceId,
        );
        final correctChoice = question.choices.firstWhere((c) => c.isCorrect);

        return ListTile(
          title: Text(
            question.text,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Your answer: ${selectedChoice.text}"),
              if (!answer.isCorrect)
                Text(
                  "Correct answer: ${correctChoice.text}",
                  style: TextStyle(color: Colors.green[700]),
                ),
            ],
          ),
          trailing: Icon(
            answer.isCorrect ? Icons.check_circle : Icons.cancel,
            color: answer.isCorrect ? Colors.green : Colors.red,
          ),
          tileColor: answer.isCorrect
              ? Colors.green[50]
              : Colors.red[50],
        );
      }).toList(),
    );
  }

  String _getPercentage() {
    final percentage = (submission.score / submission.total * 100).toInt();
    return percentage.toString();
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}