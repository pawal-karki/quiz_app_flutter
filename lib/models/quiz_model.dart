class QuizQuestions
{
  final String question;
  final List<String> options;
  final String answer;

  QuizQuestions({
    required this.question,
    required this.options,
    required this.answer,
  });
  factory QuizQuestions.fromJson(Map<String, dynamic> json) {
    List<String> options = List<String>.from(json['incorrect_answers']); //get the incorrect answers
    options.add(json['correct_answer']); //add the correct answer to the options
    options.shuffle();  //this will shuffle the options
    return QuizQuestions(
      question: json['question'],
      options: options,
      answer: json['correct_answer'],
    );
  }
}