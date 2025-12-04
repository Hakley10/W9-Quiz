import '../model/quiz.dart';

final Quiz mockQuiz = Quiz(
  id: "1",
  title: "Flutter Quiz",
  questions: [
    Question(
      id: "q1",
      text: "Who is the best teacher?",
      choices: [  
        Choice(id: "a", text: "Ronan", isCorrect: true),
        Choice(id: "b", text: "Hongly"),
        Choice(id: "c", text: "Leangsiv"),
      ],
    ),
    Question(
      id: "q2",
      text: "Who is the best teacher in the world?",
      choices: [  
        Choice(id: "a", text: "Ronan", isCorrect: true),
        Choice(id: "b", text: "Hongly"),
        Choice(id: "c", text: "Leangsiv"),
      ],
    ),
    Question(
      id: "q3",
      text: "Which language use worldwide?",
      choices: [  
        Choice(id: "a", text: "spanish"),
        Choice(id: "b", text: "English", isCorrect: true),
        Choice(id: "c", text: "Portuguese"),
      ],
    ),
  ],
);