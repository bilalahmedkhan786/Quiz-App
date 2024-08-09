import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/shared/widgets/dashboard_card.dart';
import 'package:mcqs_app/user/profile/profile_screen.dart';
import 'package:mcqs_app/user/quiz/quiz_screen.dart';
import 'package:mcqs_app/user/screens/user_dashboard.dart';

class TechQuizScreen extends StatefulWidget {
  const TechQuizScreen({super.key});

  @override
  State<TechQuizScreen> createState() => _TechQuizScreenState();
}

class _TechQuizScreenState extends State<TechQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Center(
          child: Text(
            "Tech Quiz's",
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Get.to(UserDashboard());
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        actions: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 14, 75, 180),
            ),
            child: IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                // Handle profile button press
                Get.to(ProfileScreen());
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
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
                const Text(
                  "Please Select Semester!",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      DashboardCard(
                        title: "CPISM",
                        icon: Icons.play_arrow,
                        onTap: () async {
                          // Fetch quizzes from Firestore
                          QuerySnapshot querySnapshot = await FirebaseFirestore
                              .instance
                              .collection('quizzes')
                              .where('category', isEqualTo: 'CPISM')
                              .get();

                          List<DocumentSnapshot> quizzes = querySnapshot.docs;

                          // Navigate to QuizScreen with the quizzes
                          Get.to(() => QuizScreen(quizzes: quizzes));
                        },
                      ),
                      DashboardCard(
                        title: "DISM",
                        icon: Icons.play_arrow,
                        onTap: () async {
                          // Fetch quizzes from Firestore
                          QuerySnapshot querySnapshot = await FirebaseFirestore
                              .instance
                              .collection('quizzes')
                              .where('category', isEqualTo: 'DISM')
                              .get();

                          List<DocumentSnapshot> quizzes = querySnapshot.docs;

                          // Navigate to QuizScreen with the quizzes
                          Get.to(() => QuizScreen(quizzes: quizzes));
                        },
                      ),
                      DashboardCard(
                        title: "HDSE I",
                        icon: Icons.play_arrow,
                        onTap: () async {
                          // Fetch quizzes from Firestore
                          QuerySnapshot querySnapshot = await FirebaseFirestore
                              .instance
                              .collection('quizzes')
                              .where('category', isEqualTo: 'HDSE I')
                              .get();

                          List<DocumentSnapshot> quizzes = querySnapshot.docs;

                          // Navigate to QuizScreen with the quizzes
                          Get.to(() => QuizScreen(quizzes: quizzes));
                        },
                      ),
                      DashboardCard(
                        title: "HDSE II",
                        icon: Icons.play_arrow,
                        onTap: () async {
                          // Fetch quizzes from Firestore
                          QuerySnapshot querySnapshot = await FirebaseFirestore
                              .instance
                              .collection('quizzes')
                              .where('category', isEqualTo: 'HDSE II')
                              .get();

                          List<DocumentSnapshot> quizzes = querySnapshot.docs;

                          // Navigate to QuizScreen with the quizzes
                          Get.to(() => QuizScreen(quizzes: quizzes));
                        },
                      ),
                      DashboardCard(
                        title: "ADSE I",
                        icon: Icons.play_arrow,
                        onTap: () async {
                          // Fetch quizzes from Firestore
                          QuerySnapshot querySnapshot = await FirebaseFirestore
                              .instance
                              .collection('quizzes')
                              .where('category', isEqualTo: 'ADSE I')
                              .get();

                          List<DocumentSnapshot> quizzes = querySnapshot.docs;

                          // Navigate to QuizScreen with the quizzes
                          Get.to(() => QuizScreen(quizzes: quizzes));
                        },
                      ),
                      DashboardCard(
                        title: "ADSE II",
                        icon: Icons.play_arrow,
                        onTap: () async {
                          // Fetch quizzes from Firestore
                          QuerySnapshot querySnapshot = await FirebaseFirestore
                              .instance
                              .collection('quizzes')
                              .where('category', isEqualTo: 'ADSE II')
                              .get();

                          List<DocumentSnapshot> quizzes = querySnapshot.docs;

                          // Navigate to QuizScreen with the quizzes
                          Get.to(() => QuizScreen(quizzes: quizzes));
                        },
                      ),
                      // Other cards...
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
