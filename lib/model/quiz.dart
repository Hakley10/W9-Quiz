class Quiz {
  final String id;
  final String title;
  final List<Question> questions;

  List<PlayerSubmission> submissions = [];

  Quiz({required this.id, required this.title, required this.questions});

  void addSubmission(PlayerSubmission s) {
    submissions.add(s);
  }
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

  PlayerSubmission({required this.score, required this.total});
}