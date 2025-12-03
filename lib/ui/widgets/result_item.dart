import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final int correct;
  final int total;

  const ResultItem({super.key,required this.correct, required this.total});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Score: $correct / $total"),
    );
  }
}
