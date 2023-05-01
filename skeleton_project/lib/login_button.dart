import 'package:flutter/material.dart';
import 'package:my_app/classes/theme_class.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;

  const LoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * maxButtonWidth,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
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
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  final Function()? onTap;

  const SignUpButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * maxButtonWidth,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
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
      ),
    );
  }
}
