import 'quiz.dart';

class QuizEngine {
  final Quiz quiz;

  int _currentQuestionIndex = 0;
  int _score = 0;
  List<String?> _selectedChoiceIds = [];
  List<AnswerRecord> _answerRecords = [];

  QuizEngine(this.quiz);

  Question get currentQuestion => quiz.questions[_currentQuestionIndex];
  int get currentQuestionIndex => _currentQuestionIndex;
  int get totalQuestions => quiz.questions.length;
  int get score => _score;
  bool get isQuizComplete => _currentQuestionIndex >= totalQuestions;
  List<AnswerRecord> get answerRecords => List.from(_answerRecords);

  bool get hasAnsweredCurrentQuestion =>
      _selectedChoiceIds.length > _currentQuestionIndex &&
      _selectedChoiceIds[_currentQuestionIndex] != null;

  String? get selectedChoiceId =>
      _selectedChoiceIds.length > _currentQuestionIndex
          ? _selectedChoiceIds[_currentQuestionIndex]
          : null;

  int? get selectedChoiceIndex {
    if (selectedChoiceId == null) return null;
    final choiceIds = currentQuestion.choices.map((c) => c.id).toList();
    return choiceIds.indexOf(selectedChoiceId!);
  }

  void selectAnswer(String choiceId) {
    final question = currentQuestion;
    final selectedChoice = question.choices.firstWhere((c) => c.id == choiceId);

    // Store the selection
    if (_selectedChoiceIds.length <= _currentQuestionIndex) {
      _selectedChoiceIds.add(choiceId);
    } else {
      _selectedChoiceIds[_currentQuestionIndex] = choiceId;
    }

    // Update answer record
    _updateAnswerRecord(question, selectedChoice);
  }

  bool nextQuestion() {
    if (_currentQuestionIndex < totalQuestions - 1) {
      _currentQuestionIndex++;
      return true;
    }
    return false;
  }

  bool previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      return true;
    }
    return false;
  }

  // Jump to specific question
  bool jumpToQuestion(int index) {
    if (index >= 0 && index < totalQuestions) {
      _currentQuestionIndex = index;
      return true;
    }
    return false;
  }

  // Submit the quiz and get final submission
  PlayerSubmission submitQuiz() {
    // Recalculate final score to ensure accuracy
    _score = _answerRecords.where((a) => a.isCorrect).length;

    return PlayerSubmission(
      score: _score,
      total: totalQuestions,
      answers: List.from(_answerRecords),
      timestamp: DateTime.now(),
    );
  }

  bool isQuestionAnswered(int index) {
    return index < _selectedChoiceIds.length && _selectedChoiceIds[index] != null;
  }

  // Get the answer for a specific question
  AnswerRecord? getAnswerForQuestion(int index) {
    if (index < _answerRecords.length) {
      return _answerRecords[index];
    }
    return null;
  }

  void _updateAnswerRecord(Question question, Choice selectedChoice) {
    final answerRecord = AnswerRecord(
      questionId: question.id,
      selectedChoiceId: selectedChoice.id,
      isCorrect: selectedChoice.isCorrect,
    );

    if (_answerRecords.length <= _currentQuestionIndex) {
      _answerRecords.add(answerRecord);
    } else {
      _answerRecords[_currentQuestionIndex] = answerRecord;
    }

    _score = _answerRecords.where((a) => a.isCorrect).length;
  }
}