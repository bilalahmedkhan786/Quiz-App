import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/user/quiz/tech_quiz_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<DocumentSnapshot> quizzes;

  QuizScreen({required this.quizzes});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot currentQuiz = widget.quizzes[currentQuestionIndex];
    List<dynamic> options = currentQuiz['options'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(TechQuizScreen());
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // Adding numbering to the question
                '${currentQuestionIndex + 1}. ${currentQuiz['question']}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          Icon(Icons.circle, size: 12, color: Colors.white),
                      title: Text(
                        options[index],
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onTap: () {
                        if (options[index] == currentQuiz['correctOption']) {
                          score++;
                        }
                        setState(() {
                          if (currentQuestionIndex <
                              widget.quizzes.length - 1) {
                            currentQuestionIndex++;
                          } else {
                            _showScore();
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showScore() {
    String category = widget.quizzes.first['category'];
    String userId = "userId"; // Replace with actual user ID

    // Update the user's score and progress for the specific category
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'scores.$category': FieldValue.increment(score),
      'progress.$category': FieldValue.increment(1),
    });

    // Show the score feedback dialog
    Get.defaultDialog(
      title: "Quiz Completed",
      content: Text("Your score: $score/${widget.quizzes.length}"),
      onConfirm: () {
        Get.back(); // Go back to the previous screen
      },
    );
  }
}
