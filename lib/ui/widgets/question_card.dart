import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import 'answer_option.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedIndex;
  final Function(int) onTap;

  const QuestionCard({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              question.text,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            ...List.generate(question.answers.length, (i) {
              return AnswerOption(
                text: question.answers[i].text,
                isSelected: selectedIndex == i,
                onTap: () => onTap(i),
              );
            })
          ],
        ),
      ),
    );
  }
}
