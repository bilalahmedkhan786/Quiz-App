import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/admin/quizzes/manage_quizs.dart';

class AddQuizScreen extends StatefulWidget {
  @override
  _AddQuizScreenState createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _correctOptionController =
      TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
            onPressed: () {
              Get.to(ManageQuizzesScreen());
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Text(
          'Add Quiz',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(229, 16, 15, 15),
              Color.fromARGB(255, 0, 0, 0)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _questionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Question',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: _option1Controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Option 1',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: _option2Controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Option 2',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: _option3Controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Option 3',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: _correctOptionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Correct Option',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: [
                  'CPISM',
                  'DISM',
                  'HDSE I',
                  'HDSE II',
                  'ADSE I',
                  'ADSE II'
                ].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                dropdownColor: Colors.black87,
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                  backgroundColor: Color.fromARGB(255, 1, 30, 53),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await _firestore.collection('quizzes').add({
                    'question': _questionController.text,
                    'options': [
                      _option1Controller.text,
                      _option2Controller.text,
                      _option3Controller.text,
                    ],
                    'correctOption': _correctOptionController.text,
                    'category': _selectedCategory,
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'Save Quiz',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
