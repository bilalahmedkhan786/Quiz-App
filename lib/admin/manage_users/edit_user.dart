import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcqs_app/admin/manage_users/manage_user.dart';

class EditUserScreen extends StatelessWidget {
  final String userId;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  EditUserScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
            onPressed: () {
              Get.to(ManageUsersScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        title: Text(
          'Edit User',
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
        child: FutureBuilder<DocumentSnapshot>(
          future: _firestore.collection('users').doc(userId).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var userData = snapshot.data!;
            _nameController.text = userData['name'];
            _emailController.text = userData['email'];
            _passwordController.text = userData['password'];
            _descriptionController.text = userData['description'];
            _ageController.text = userData['age'];
            _maritalStatusController.text = userData['maritalstatus'];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.blue)),
                  ),
                  TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextField(
                    controller: _ageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Age',
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextField(
                    controller: _maritalStatusController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Marital Status',
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      await _firestore.collection('users').doc(userId).update({
                        'name': _nameController.text,
                        'email': _emailController.text,
                        'password': _passwordController.text,
                        'description': _descriptionController.text,
                        'age': _ageController.text,
                        'maritalstatus': _maritalStatusController.text,
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Update User'),
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
