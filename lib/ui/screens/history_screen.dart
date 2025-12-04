import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import '../../services/quiz.service.dart';
import '../widgets/result_item.dart';

class HistoryScreen extends StatefulWidget {
  final Quiz quiz;

  const HistoryScreen({super.key, required this.quiz});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final QuizService _quizService = QuizService();
  late Future<List<PlayerSubmission>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _quizService.getSubmissions();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz History"),

      ),
      body: FutureBuilder<List<PlayerSubmission>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final submissions = snapshot.data ?? [];

          if (submissions.isEmpty) {
            return const Center(
              child: Text(
                "No quiz history yet.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: submissions.length,
            itemBuilder: (_, i) => ResultItem(
              submission: submissions[i],
              quiz: widget.quiz,
            ),
          );
        },
      ),
    );
  }
}