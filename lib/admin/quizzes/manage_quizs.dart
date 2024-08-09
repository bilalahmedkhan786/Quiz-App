import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/admin/admin_dashboard.dart';
import 'package:mcqs_app/admin/quizzes/add_quiz.dart';
import 'package:mcqs_app/admin/quizzes/edit_quiz.dart';

class ManageQuizzesScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        // leading:  Icon(
        //   Icons.arrow_back_ios_new,
        //   color: Colors.white,
        // ),
        leading: IconButton(
            onPressed: () {
              Get.to(AdminDashboard());
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Text('Manage Quizzes',
            style: TextStyle(
              color: Colors.white,
            )),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('quizzes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final quizzes = snapshot.data!.docs;
            return ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                var quiz = quizzes[index];
                return ListTile(
                  title: Text(
                    quiz['question'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Options: ${quiz['options'].join(', ')}\nCorrect Option: ${quiz['correctOption']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await _firestore
                          .collection('quizzes')
                          .doc(quiz.id)
                          .delete();
                    },
                  ),
                  onTap: () {
                    // Navigate to edit quiz screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditQuizScreen(quizId: quiz.id),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add quiz screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuizScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
