import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IT Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  int _score = 0;
  bool _isDisposed = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'questionText': '1)What is JavaScript used for?',
      'answers': [
        {'text': 'Styling web pages', 'correct': false},
        {'text': 'Programming the server', 'correct': false},
        {'text': 'Adding interactivity to web pages', 'correct': true},
        {'text': 'None of the above', 'correct': false},
      ],
    },
    {
      'questionText': '2)The first search engine on internet is?',
      'answers': [
        {'text': 'Google', 'correct': false},
        {'text': 'Archie', 'correct': true},
        {'text': 'Yahoo', 'correct': false},
        {'text': 'Bing', 'correct': false},
      ],
    },
    {
      'questionText': '3)Who is known as the father of Internet?',
      'answers': [
        {'text': 'Vinton Cerf', 'correct': true},
        {'text': 'lorenx walinson', 'correct': false},
        {'text': 'peter altman', 'correct': false},
        {'text': 'None of the above', 'correct': false},
      ],
    },
    {
      'questionText': '4)Who invented Computer mouse?',
      'answers': [
        {'text': 'Engelbert Doughles', 'correct': false},
        {'text': 'Doughles Engelbert', 'correct': true},
        {'text': 'Christopher Latham Sholes', 'correct': false},
        {'text': 'None of above', 'correct': false},
      ],
    },
    {
      'questionText': '5)Which of the following is not a DBMS?',
      'answers': [
        {'text': 'COBOL', 'correct': true},
        {'text': 'Sybase', 'correct': false},
        {'text': 'Oracle', 'correct': false},
        {'text': 'Nimble Data', 'correct': false},
      ],
    },
    {
      'questionText':
          '6)Which of the following sorting algorithms has the worst time complexity??',
      'answers': [
        {'text': 'Merge Sort', 'correct': false},
        {'text': 'Bubble Sort', 'correct': true},
        {'text': 'Quick Sort', 'correct': false},
        {'text': 'Insertion Sort', 'correct': false},
      ],
    },
    {
      'questionText':
          '7)In Python, which of the following is NOT a valid data type??',
      'answers': [
        {'text': 'Array', 'correct': true},
        {'text': 'dictionary', 'correct': false},
        {'text': 'set', 'correct': false},
        {'text': 'tuple', 'correct': false},
      ],
    },
    {
      'questionText':
          '8)Which security measure involves hiding data within other data to conceal its existence?',
      'answers': [
        {'text': ' Intrusion Detection Systems (IDS)', 'correct': false},
        {'text': 'Steganography', 'correct': true},
        {'text': 'Firewalls', 'correct': false},
        {'text': 'None of above', 'correct': false},
      ],
    },
    {
      'questionText':
          '9)Which programming language is used for Android app development?',
      'answers': [
        {'text': 'Java', 'correct': true},
        {'text': 'Python', 'correct': false},
        {'text': 'C++', 'correct': false},
        {'text': 'None of the above', 'correct': false},
      ],
    },
    {
      'questionText': '10)When was IOE,WRC established?',
      'answers': [
        {'text': '2050', 'correct': false},
        {'text': '2038', 'correct': true},
        {'text': '2040', 'correct': false},
        {'text': '2045', 'correct': false},
      ],
    },
  ];

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _answerQuestion(bool isCorrect) {
    if (!mounted) return;

    Future.microtask(() {
      if (!mounted) return;

      setState(() {
        if (isCorrect) {
          _score++;
        }
        if (_questionIndex < _questions.length - 1) {
          _questionIndex++;
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Result(_score, _questions.length, _restartQuiz),
            ),
          );
        }
      });
    });
  }

  void _restartQuiz() {
    if (!_isDisposed) {
      setState(() {
        _questionIndex = 0;
        _score = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IT Quiz'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 3, 226, 3),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _questionIndex < _questions.length
            ? Quiz(
                questionIndex: _questionIndex,
                questions: _questions,
                answerQuestion: _answerQuestion,
              )
            : Result(_score, _questions.length, _restartQuiz),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> questions;
  final Function(bool) answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          questions[questionIndex]['questionText'],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        ...(questions[questionIndex]['answers'] as List<Map<String, dynamic>>)
            .map((answer) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () => answerQuestion(answer['correct']),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 227, 232, 71),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                answer['text'],
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class Result extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final Function restartQuiz;

  Result(this.score, this.totalQuestions, this.restartQuiz);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'You scored $score out of $totalQuestions!',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => restartQuiz(),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: Text(
              'Restart Quiz',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
