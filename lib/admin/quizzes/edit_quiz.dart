import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/admin/quizzes/manage_quizs.dart';

class EditQuizScreen extends StatefulWidget {
  final String quizId;

  EditQuizScreen({required this.quizId});

  @override
  _EditQuizScreenState createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
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
          'Edit Quiz',
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
        child: FutureBuilder<DocumentSnapshot>(
          future: _firestore.collection('quizzes').doc(widget.quizId).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var quizData = snapshot.data!;
            _questionController.text = quizData['question'];
            _option1Controller.text = quizData['options'][0];
            _option2Controller.text = quizData['options'][1];
            _option3Controller.text = quizData['options'][2];
            _correctOptionController.text = quizData['correctOption'];
            _selectedCategory = quizData['category'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _questionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Question',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextField(
                    controller: _option1Controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Option 1',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextField(
                    controller: _option2Controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Option 2',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextField(
                    controller: _option3Controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Option 3',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextField(
                    controller: _correctOptionController,
                    style: TextStyle(color: Colors.white),
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
                      'ADSE II',
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 15),
                      backgroundColor: Color.fromARGB(255, 1, 30, 53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await _firestore
                          .collection('quizzes')
                          .doc(widget.quizId)
                          .update({
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
                    child: const Text(
                      'Update Quiz',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
