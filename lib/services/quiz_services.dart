import 'dart:convert';
import '../models/quiz_model.dart';
import 'package:http/http.dart' as http;

Future<List<QuizQuestions>> fetchQuizQuestions() async{
  final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=20&difficulty=medium'));
  if(response.statusCode == 200){
    final jsonData = json.decode(response.body);
    final List<dynamic> questionsJson = jsonData['results'];
    final List<QuizQuestions> questions = [];
    for(var questions in questionsJson){
      questions.add(QuizQuestions.fromJson(questions));
    }
    return questions;
  }
  else{
    throw Exception('Failed to load data');
  }
}