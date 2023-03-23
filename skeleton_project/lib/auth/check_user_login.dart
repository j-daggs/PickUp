import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/event_home_page.dart';
import 'auth_page.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } 
        else {
          return const AuthPage();
          }
        },
      )
    );
  }
}
