import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mcqs_app/admin/admin_dashboard.dart';
import 'package:mcqs_app/auth/firebase_auth.dart';
import 'package:mcqs_app/pages/register.dart';
import 'package:mcqs_app/user/screens/user_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Auth myauth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            // colors: [Colors.lightBlue, Colors.blueAccent],
            colors: [
              Color.fromARGB(246, 16, 15, 15),
              Color.fromARGB(255, 0, 0, 0)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined),
                      labelText: 'Email',
                      filled: true,
                      isDense: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      labelText: 'Password',
                      filled: true,
                      isDense: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Forgot your Password?",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150, vertical: 15),
                      backgroundColor: Color.fromARGB(255, 1, 30, 53),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();

                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);

                          // Check if the user is the admin
                          if (email == 'admin@gmail.com' &&
                              password == 'admin123') {
                            Get.to(AdminDashboard());
                          } else {
                            Get.to(UserDashboard());
                          }
                        } on FirebaseAuthException catch (e) {
                          // Handle error, show a message, etc.
                          Get.snackbar("Error", e.message!,
                              colorText: Colors.white,
                              backgroundColor: Color.fromARGB(255, 0, 58, 106));
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(
                    color: Color.fromARGB(158, 158, 158, 158),
                    endIndent: Checkbox.width,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(11),
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 61, 67, 78)),
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(37, 171, 157, 157),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/google.png',
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 61, 67, 78)),
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(37, 171, 157, 157),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        height: 60,
                        width: 60,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 61, 67, 78)),
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromARGB(37, 171, 157, 157),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account yet?",
                          style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 5),
                      GestureDetector(
                          onTap: () {
                            Get.to(RegisterScreen());
                          },
                          child: Text("Register",
                              style: TextStyle(color: Colors.blue))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
