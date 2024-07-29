import 'package:flutter/material.dart';
import 'package:quiz/models/gender_model.dart';
import 'package:quiz/services/gender_service.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String? gender;
  double? probability;

  Future<GenderModel> fetchGenderData(String name) async {
    final GenderModel genderModel = await GenderService().fetchGenderData(name);
    setState((){
      gender = genderModel.gender;
      probability = genderModel.probability;
    });
    return genderModel;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analyze Gender'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _firstNameController,
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              String fullName =
                  '${_firstNameController.text} ${_lastNameController.text}';
              fetchGenderData(fullName);
            },
            child: Text('Analyze'),
          ),
          SizedBox(
            height: 20,
          ),
          Text('Gender: $gender'),
          SizedBox(
            height: 20,
          ),
          Text('Probability: $probability'),
        ],
      ),
    );
  }
}