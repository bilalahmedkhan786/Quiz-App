import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/shared/widgets/dashboard_card.dart';
import 'package:mcqs_app/user/profile/profile_screen.dart';
import 'package:mcqs_app/user/quiz/tech_quiz_screen.dart';
import 'package:mcqs_app/user/screens/scoreboard_screen.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Center(
          child: Text(
            'Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
        leading: const Icon(
          Icons.grid_view,
          color: Colors.white,
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
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
                  "Welcome to QuizApp!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      DashboardCard(
                        title: "Start Quiz",
                        icon: Icons.play_arrow,
                        onTap: () {
                          // Handle start quiz
                          Get.to(TechQuizScreen());
                        },
                      ),
                      DashboardCard(
                        title: "My Scores",
                        icon: Icons.score,
                        onTap: () {
                          // Handle view scores
                          Get.to(ScoreboardScreen());
                        },
                      ),
                      DashboardCard(
                        title: "Progress",
                        icon: Icons.show_chart,
                        onTap: () {
                          // Handle view progress
                        },
                      ),
                      DashboardCard(
                        title: "Settings",
                        icon: Icons.settings,
                        // color: const Color.fromARGB(255, 4, 79, 141),
                        onTap: () {
                          // Handle settings
                        },
                      ),
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
