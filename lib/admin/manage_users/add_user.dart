import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/admin/manage_users/manage_user.dart';

class AddUserScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(ManageUsersScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: Colors.black87,
        title: Text(
          'Add User',
          style: TextStyle(color: Colors.white),
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
                controller: _nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextField(
                controller: _descriptionController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _ageController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: _maritalStatusController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(labelText: 'Marital Status'),
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
                  await _firestore.collection('users').add({
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'password': _passwordController.text,
                    'description': _descriptionController.text,
                    'age': _ageController.text,
                    'marital_status': _maritalStatusController.text,
                  });
                  Navigator.pop(context);
                },
                child: Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
