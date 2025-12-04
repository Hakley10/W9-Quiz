import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/quiz.dart';

class QuizService {
  static const String _submissionsKey = 'quiz_submissions';

  Future<void> saveSubmission(PlayerSubmission submission) async {
    final prefs = await SharedPreferences.getInstance();
    final submissionsJson = prefs.getStringList(_submissionsKey) ?? [];

    submissionsJson.add(jsonEncode({
      'score': submission.score,
      'total': submission.total,
      'timestamp': submission.timestamp.toIso8601String(),
      'answers': submission.answers.map((a) => {
        'questionId': a.questionId,
        'selectedChoiceId': a.selectedChoiceId,
        'isCorrect': a.isCorrect,
      }).toList(),
    }));

    await prefs.setStringList(_submissionsKey, submissionsJson);
  }

  Future<List<PlayerSubmission>> getSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    final submissionsJson = prefs.getStringList(_submissionsKey) ?? [];

    return submissionsJson.map((json) {
      final data = jsonDecode(json);
      return PlayerSubmission(
        score: data['score'],
        total: data['total'],
        timestamp: DateTime.parse(data['timestamp']),
        answers: (data['answers'] as List).map((a) => AnswerRecord(
          questionId: a['questionId'],
          selectedChoiceId: a['selectedChoiceId'],
          isCorrect: a['isCorrect'],
        )).toList(),
      );
    }).toList();
  }

  Future<void> clearAllSubmissions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_submissionsKey);
  }
}