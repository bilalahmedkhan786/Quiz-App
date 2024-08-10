import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/pages/login.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore data = FirebaseFirestore.instance;

  Future<User?> register(String name, String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      // Add user data to Firestore
      if (user != null) {
        await data.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'description': '', // or any other default value
          'image_url': '', // or any other default value
        });
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void logout(BuildContext context) {
    auth.signOut().then((value) {
      Get.snackbar("User Logout", "Logout Successful",
          colorText: Colors.white, backgroundColor: Colors.blue);
      Get.offAll(() => const LoginScreen());
    });
  }

  void forgetpassword(String myemail, BuildContext context) {
    auth.sendPasswordResetEmail(email: myemail).then((value) {
      Get.snackbar("Forgot Password", "Email Sent");
    });
  }
}
