import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import '../widgets/result_item.dart';

class HistoryScreen extends StatelessWidget {
  final List<PlayerSubmission> history;

const HistoryScreen({super.key,required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("History")),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (_, i) => ResultItem(
          correct: history[i].score,
          total: history[i].total,
        ),
      ),
    );
  }
}
