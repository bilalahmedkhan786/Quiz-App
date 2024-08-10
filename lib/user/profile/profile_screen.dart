import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/shared/auth/firebase_auth.dart';
import 'package:mcqs_app/user/profile/edit_profile.dart';
import 'package:mcqs_app/user/screens/user_dashboard.dart';

import '../../shared/widgets/profile_menu_wideget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Auth myauth = Auth();
  bool _isDarkMode = Get.isDarkMode;

  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String name = "";
  String email = "";
  String description = "";
  String profileImageUrl = "";

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user!.uid).get();
      if (userData.exists) {
        setState(() {
          name = userData['name'] ?? '';
          email = userData['email'] ?? '';
          description = userData['description'] ?? '';
          profileImageUrl = userData['image_url'] ?? '';
        });
      }
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Get.to(UserDashboard(
            ));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              Get.changeThemeMode(
                  _isDarkMode ? ThemeMode.light : ThemeMode.dark);
              _toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : null,
                  child: profileImageUrl.isEmpty
                      ? Icon(Icons.person, size: 80)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),
            // SizedBox(
            //   width: 200,
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       // Navigate to EditProfile and wait for result
            //       final result = await Get.to(() => const EditProfile());
            //       if (result == true) {
            //         // Refresh user data after editing
            //         _fetchUserData();
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color.fromARGB(255, 125, 164, 231),
            //       shadowColor: Colors.black,
            //       shape: const StadiumBorder(),
            //     ),
            //     child: const Text(
            //       "Edit Profile",
            //       style: TextStyle(
            //         color: Colors.black,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            const Divider(color: Colors.transparent),
            const SizedBox(height: 10),
            ProfileMenuWidget(
              title: "Edit Profile",
              textColor: Colors.white,
              icon: Icons.edit,
              onPress: () async {
                final result = await Get.to(() => const EditProfile());
                if (result == true) {
                  // Refresh user data after editing
                  _fetchUserData();
                }
              },
            ),
            ProfileMenuWidget(
                title: "Favorites",
                textColor: Colors.white,
                icon: Icons.favorite,
                onPress: () {}),
            ProfileMenuWidget(
                title: "User Management",
                textColor: Colors.white,
                icon: Icons.supervised_user_circle_outlined,
                onPress: () {}),
            const Divider(color: Color.fromARGB(17, 0, 0, 0)),
            const SizedBox(height: 10),
            ProfileMenuWidget(
                title: "Information",
                textColor: Colors.white,
                icon: Icons.info_outline_rounded,
                onPress: () {}),
            ProfileMenuWidget(
              title: "Logout",
              textColor: Colors.red,
              icon: Icons.logout_sharp,
              endIcon: false,
              onPress: () {
                myauth.logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
