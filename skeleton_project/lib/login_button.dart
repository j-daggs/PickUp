import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:my_app/classes/theme_class.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;

  const LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: greenPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: brightText,
              fontWeight: FontWeight.bold,
              fontSize: bodyFontSize,
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  final Function()? onTap;

  const SignUpButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: greenPrimary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Sign up",
            style: TextStyle(
              color: brightText,
              fontWeight: FontWeight.bold,
              fontSize: bodyFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
