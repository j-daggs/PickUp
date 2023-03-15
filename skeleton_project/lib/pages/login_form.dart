import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/classes/text_field_class.dart';

import '../login_button.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginForm({Key? key, required this.showRegisterPage}) : super(key: key);

  // Creates state of login form for observing
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
// text controllers to observe changes
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Sign in method on click of login button
  Future signIn() async {
    // Loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // Attempt to sign in, if failure, show validation error message
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongDetailsMessage(e.code);
    }

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

  // Memory Management
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                  const Text('Welcome!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  const Text('Login or sign up to continue!',
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 25),

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
                  const SizedBox(height: 25),

                  // Log in button and on Tap call signIn
                  LoginButton(onTap: signIn),
                  const SizedBox(height: 10),

                  // Register button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(' Register now',
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
