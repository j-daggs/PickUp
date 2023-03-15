import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({Key? key}) : super(key: key);

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('signed in as: ${user.email!}'),
            const SizedBox(height: 20),
            MaterialButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              },
              color: Colors.blue,
              child: const Text('Sign Out')
            )
          ],
        ),
      ),
    );
  }
}
