import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/admin/manage_users/manage_user.dart';
import 'package:mcqs_app/admin/quizzes/manage_quizs.dart';
import 'package:mcqs_app/auth/firebase_auth.dart';

class AdminDashboard extends StatelessWidget {
  Auth myauth = Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        backgroundColor: Colors.black87,
        title: Center(
          child: Text(
            'Admin Dashboard',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                myauth.logout(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              )),
        ],
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
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            // User Management
            AdminCard(
              title: 'Manage Users',
              icon: Icons.person,
              onTap: () {
                Get.to(ManageUsersScreen());
              },
            ),
            // Quiz Management
            AdminCard(
              title: 'Manage Quizzes',
              icon: Icons.quiz,
              onTap: () {
                Get.to(ManageQuizzesScreen());
              },
            ),
            AdminCard(
              title: 'Settings',
              icon: Icons.settings,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  AdminCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 4, 79, 141),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
