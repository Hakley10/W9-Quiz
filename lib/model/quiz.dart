class Quiz {
  final String id;
  final String title;
  final List<Question> questions;

  Quiz({required this.id, required this.title, required this.questions});

}

class Question {
  final String id;
  final String text;
  final List<Choice> choices;  

  Question({required this.id, required this.text, required this.choices});
}

class Choice { 
  final String id;
  final String text;
  final bool isCorrect;

  Choice({required this.id, required this.text, this.isCorrect = false});
}

class PlayerSubmission {
  final int score;
  final int total;
  final List<AnswerRecord> answers;
  final DateTime timestamp;

  PlayerSubmission({
    required this.score,
    required this.total,
    required this.answers,
    required this.timestamp,
  });
}

class AnswerRecord {
  final String questionId;
  final String selectedChoiceId;
  final bool isCorrect;

  AnswerRecord({
    required this.questionId,
    required this.selectedChoiceId,
    required this.isCorrect,
  });
}

