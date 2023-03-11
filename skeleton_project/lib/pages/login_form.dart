import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim());
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 24
                        )
                      ),
                  const SizedBox(height: 10),
                  const Text(
                    'Login or sign up to continue!',
                    style: TextStyle(
                      fontSize: 20
                      )
                    ),
                  const SizedBox(height: 50),

                  // email textfield UI and controller
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // password textfield and controller
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Log in button and onClick call signIn
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: signIn,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12.0)),
                          child: const Center(
                              child: Text('Login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                            )
                          )
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

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
                                color: Colors.red, fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      );
  }
}
