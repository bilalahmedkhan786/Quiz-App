import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcqs_app/user/profile/profile_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController maritalstatusController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user!.uid).get();
      setState(() {
        nameController.text = userData['name'];
        emailController.text = userData['email'];
        descriptionController.text = userData['description'];
        ageController.text = userData['age'].toString();
        maritalstatusController.text = userData['maritalstatus'];
      });
    }
  }

  Future<void> _updateUserData() async {
    if (user != null) {
      String? imageUrl;
      if (_image != null) {
        try {
          final ref =
              _storage.ref().child('profile_images').child('${user!.uid}.jpg');
          await ref.putFile(_image!);
          imageUrl = await ref.getDownloadURL();
        } catch (e) {
          Get.snackbar("Error", "Failed to upload image");
          return;
        }
      }
      try {
        await _firestore.collection('users').doc(user!.uid).update({
          'name': nameController.text,
          'email': emailController.text,
          'description': descriptionController.text,
          'age': int.parse(ageController.text),
          'maritalstatus': maritalstatusController.text,
          if (imageUrl != null) 'image_url': imageUrl,
        });

        print("ffhff");

        // Update data in profile screen
        Get.back(result: true); // Return to profile screen and refresh data
        Get.snackbar("Profile Update", "Profile updated successfully",
            colorText: Colors.white, backgroundColor: Colors.blue);
      } catch (error) {
        Get.snackbar("Error", "Failed to update profile: $error",
            colorText: Colors.white,
            backgroundColor: Color.fromARGB(255, 1, 30, 53));
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          onPressed: () {
            Get.to(const ProfileScreen());
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InkWell(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: 'Age',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: maritalstatusController,
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(0.8),
                filled: true,
                labelText: 'Marital Status',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserData,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                backgroundColor: Color.fromARGB(255, 1, 30, 53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Save Changes",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
