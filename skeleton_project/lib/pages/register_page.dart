import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../login_button.dart';
import '../classes/text_field_class.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginForm;
  const RegisterPage({Key? key, required this.showLoginForm}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
// text controllers to observe changes
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  // Memory Management
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future signUp() async {
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      } else {
        wrongDetailsMessage('Passwords don\'t match');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongDetailsMessage(e.code);
    }

    // call method to add user details
    // addUserDetails(_usernameController.text.trim(),
    //     _emailController.text.trim(), _passwordController.text.trim());
  }

  // adds user details to Firestore Database in User collection
  Future addUserDetails(String username, String email, String password) async {
    await FirebaseFirestore.instance
        .collection('User')
        .add({'Username': username, 'Email:': email, 'Password': password});
  }

  // wrong details message popup
  void wrongDetailsMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              'Incorrect Username or Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // Password match check
  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Welcome message
                  const Text('Hello There!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const SizedBox(height: 10),
                  const Text('Register below with your details',
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 50),

                  // Username text field and controller (ADDING LATER)
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFieldObject(
                          controller: _usernameController,
                          hintText: 'Username',
                          obscureText: false)),
                  const SizedBox(height: 10),

                  // email textfield UI and controller
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFieldObject(
                          controller: _emailController,
                          hintText: 'Email',
                          obscureText: false)),
                  const SizedBox(height: 10),

                  // password textfield and controller
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFieldObject(
                          controller: _passwordController,
                          hintText: 'Password',
                          obscureText: true)),
                  const SizedBox(height: 10),

                  // confirm password textfield and controller
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFieldObject(
                          controller: _confirmPasswordController,
                          hintText: 'Re-enter password',
                          obscureText: true)),
                  const SizedBox(height: 10),

                  // Register Button and on button click sign up new user
                  SignUpButton(onTap: signUp),
                  const SizedBox(height: 25),

                  // Sign in button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a member? Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginForm,
                        child: const Text(' here',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
