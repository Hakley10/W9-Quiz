import 'package:flutter/material.dart';
import '../../data/quiz_data.dart';
import '../../model/quiz.dart';
import '../../model/quiz_engine.dart';
import '../../services/quiz.service.dart';
import 'history_screen.dart';
import 'question_screen.dart';
import 'result_screen.dart';
import 'welcome_screen.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({super.key});

  @override
  State<ScreenManager> createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  String _currentScreen = 'welcome';
  late Quiz _quiz;
  late QuizEngine _quizEngine;
  PlayerSubmission? _currentSubmission;
  final QuizService _quizService = QuizService();
  
  @override
  void initState() {
    super.initState();
    _quiz = mockQuiz;
    _quizEngine = QuizEngine(_quiz);
  }
  
  void _goToWelcome() {
    setState(() {
      _currentScreen = 'welcome';
    });
  }
  
  void _goToQuiz() {
    setState(() {
      _currentScreen = 'quiz';
      _quizEngine = QuizEngine(_quiz);
    });
  }
  
  void _goToResult(PlayerSubmission submission) {
    setState(() {
      _currentScreen = 'result';
      _currentSubmission = submission;
    });
  }
  
  void _showHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HistoryScreen(quiz: _quiz),
      ),
    );
  }
  
  void _restartQuiz() {
    setState(() {
      _currentScreen = 'welcome';
      _quizEngine = QuizEngine(_quiz); 
      _currentSubmission = null; 
    });
  }
  
  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case 'welcome':
        return WelcomeScreen(
          onStartQuiz: _goToQuiz,
          onShowHistory: _showHistory,
        );
      case 'quiz':
        return QuestionScreen(
          quizEngine: _quizEngine,
          onFinish: (submission) async {
            await _quizService.saveSubmission(submission);
            _goToResult(submission);
          },
          onBack: _goToWelcome,
        );
      case 'result':
        return ResultScreen(
          quiz: _quiz,
          submission: _currentSubmission!,
          onRestart: _restartQuiz, 
        );
      default:
        return const Scaffold(
          body: Center(child: Text('Screen not found')),
        );
    }
  }
}