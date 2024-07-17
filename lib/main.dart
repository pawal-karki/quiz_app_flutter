import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizHomePage(),
    );
  }
}

Future<List<dynamic>> loadJson() async {
  String jsonString = await rootBundle.loadString('assets/data.json');
  return json.decode(jsonString)['quiz'];
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  List<dynamic>? _questionsList;
  int _currentQuestionList = 0;
  int _score = 0;
  bool _quizFinished = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    List<dynamic> questions = await loadJson();
    setState(() {
      _questionsList = questions;
    });
  }

  void _answerQuestion(String answer) {
    if (answer == _questionsList![_currentQuestionList]['answer']) {
      _score++;
    }
    setState(() {
      if (_currentQuestionList < _questionsList!.length - 1) {
        _currentQuestionList++;
      } else {
        _quizFinished = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionList = 0;
      _score = 0;
      _quizFinished = false;
    });
  }

  Widget _buildOptionButton(String option) {
    return ElevatedButton(
      onPressed: () {
        _answerQuestion(option);
      },
      child: Text(option),
    );
  }

  List<Widget> _buildOptions() {
    List<Widget> options = [];
    for (String option in _questionsList![_currentQuestionList]['options']) {
      options.add(_buildOptionButton(option));
      options.add(SizedBox(height: 10));
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    if (_quizFinished) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
            "Sample Quiz",
            style: TextStyle(color: Colors.white),
          
          )),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Your Score: $_score/ ${_questionsList!.length}'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _restartQuiz,
                  child: Text('Restart Quiz'),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 10,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_questionsList![_currentQuestionList]['question']),
                SizedBox(height: 20),
                ..._buildOptions(),
              ],
            ),
          ),
        ),
      );
    }
  }
}
