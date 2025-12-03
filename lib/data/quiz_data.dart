import '../model/quiz.dart';

final Quiz mockQuiz = Quiz(
  id: "1",
  title: "Flutter Quiz",
  questions: [
    Question(
      id: "q1",
      text: "Who is the best teacher?",
      answers: [
        Answer(id: "a", text: "Ronan", isCorrect: true),
        Answer(id: "b", text: "Hongly"),
        Answer(id: "c", text: "Leangsiv"),
      ],
    ),
    Question(
      id: "q2",
      text: "Who is the best teacher in the world?",
      answers: [
        Answer(id: "a", text: "Ronan", isCorrect: true),
        Answer(id: "b", text: "Hongly"),
        Answer(id: "c", text: "Leangsiv"),
      ],
    ),

    // --- NEW QUESTIONS ---
    Question(
      id: "q3",
      text: "Which language use worldwide?",
      answers: [
        Answer(id: "a", text: "spanish"),
        Answer(id: "b", text: "English", isCorrect: true),
        Answer(id: "c", text: "Portuguese"),
      ],
    ),


  ],
);

