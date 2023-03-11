import 'package:flutter/material.dart';
import '../pages/login_form.dart';
import '../pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // intiallly, show the login page
  bool showLoginForm = true;

  void toggleScreens() {
    setState( () {
        showLoginForm = !showLoginForm;
      }
    );
  } 

  @override
  Widget build(BuildContext context) {
    if (showLoginForm) {
      return LoginForm(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginForm: toggleScreens);
    }
  }
}
