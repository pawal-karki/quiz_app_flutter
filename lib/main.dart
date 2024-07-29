import 'dart:convert';

import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screens/gender_screen.dart';
import 'package:quiz/screens/quiz_screen.dart';
import '../models/quiz_models.dart';
import '../services/quiz_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainQuizHome(),
        theme: ThemeData(
            textTheme: GoogleFonts.ralewayTextTheme(),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: Size(200, 50),
              ),
            )));
  }
}

class MainQuizHome extends StatelessWidget {
  const MainQuizHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 10,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizHomePage()));
              },
              child: Text('Play Quiz'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GenderScreen()));
              },
              child: Text('Analyze Gender'),
            ),
          ],
        ),
      ),
    );
  }
}
