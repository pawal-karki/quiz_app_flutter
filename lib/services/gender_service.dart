import 'package:quiz/models/gender_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderService{
  Future <GenderModel> fetchGenderData(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io?name=$name'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return GenderModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }
}