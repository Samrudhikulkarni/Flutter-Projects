import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State createState() => _QuizAppState();
}

class _QuizAppState extends State {
  List<Map> allQuestions = [
    {
      "questions": "Who is the founder of Microsoft?",
      "options": ["Steve Jobs", "Bill Gates", "Lary Page", "Elon Musk"],
      "correctAnswer": 1
    },
    {
      "questions": "Who is the founder of Google?",
      "options": ["Steve Jobs", "Bill Gates", "Lary Page", "Elon Musk"],
      "correctAnswer": 2
    },
    {
      "questions": "Who is the founder of SpaceX?",
      "options": ["Steve Jobs", "Bill Gates", "Lary Page", "Elon Musk"],
      "correctAnswer": 3
    },
    {
      "questions": "Who is the founder of Meta?",
      "options": ["Steve Jobs", "Mark Zukerberg", "Lary Page", "Elon Musk"],
      "correctAnswer": 1
    },
    {
      "questions": "Who is the founder of Apple?",
      "options": ["Steve Jobs", "Bill Gates", "Lary Page", "Elon Musk"],
      "correctAnswer": 0
    },
  ];

  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  int result = 0;

  WidgetStateProperty<Color?> checkAnswer(int answerIndex) {
    if (selectedAnswerIndex != -1) {
      if (answerIndex == allQuestions[currentQuestionIndex]["correctAnswer"]) {
        return const WidgetStatePropertyAll(Colors.green);
      } else if (selectedAnswerIndex == answerIndex) {
        return const WidgetStatePropertyAll(Colors.red);
      } else {
        return const WidgetStatePropertyAll(null);
      }
    } else {
      return const WidgetStatePropertyAll(null);
    }
  }

  bool questionPage = true;

  @override
  Widget build(BuildContext context) {
    return isQuestionScreen();
  }

  Scaffold isQuestionScreen() {
    if (questionPage == true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz App",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 130,
                ),
                Text(
                  "Question:${currentQuestionIndex + 1}/${allQuestions.length}",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: 380,
              height: 50,
              child: Text(
                allQuestions[currentQuestionIndex]["questions"],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: checkAnswer(0),
                ),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 0;
                    setState(() {});
                  }
                },
                child: Text(
                  allQuestions[currentQuestionIndex]['options'][0],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: checkAnswer(1),
                ),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 1;
                    setState(() {});
                  }
                },
                child: Text(
                  allQuestions[currentQuestionIndex]['options'][1],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: checkAnswer(2),
                ),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 2;
                    setState(() {});
                  }
                },
                child: Text(
                  allQuestions[currentQuestionIndex]['options'][2],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: checkAnswer(3),
                ),
                onPressed: () {
                  if (selectedAnswerIndex == -1) {
                    selectedAnswerIndex = 3;
                    setState(() {});
                  }
                },
                child: Text(
                  allQuestions[currentQuestionIndex]['options'][3],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF00003f),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedAnswerIndex != -1) {
              if (selectedAnswerIndex ==
                  allQuestions[currentQuestionIndex]['correctAnswer']) {
                result++;
              }
              if (currentQuestionIndex < allQuestions.length - 1) {
                currentQuestionIndex++;
              } else {
                questionPage = false;
              }
              selectedAnswerIndex = -1;
              setState(() {});
            }
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.forward, color: Colors.white),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz Result",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text("Congratulations!!",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.amber,
                  )),
              Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSzSW23HMDeMNkukMxQRYI9ZPPe9E8J5VBVqox3nVTS-SwD1LQUx3Jz4FR1uugeO2cGL4&usqp=CAU"),
              const SizedBox(
                height: 30,
              ),
              Text("Score:$result/${allQuestions.length}",
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 30,
                  )),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  questionPage = true;
                  selectedAnswerIndex = -1;
                  currentQuestionIndex = 0;
                  setState(() {});
                },
                child: const Text(
                  "Restart",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
