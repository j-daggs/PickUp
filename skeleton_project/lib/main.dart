import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/check_user_login.dart';
import 'firebase_options.dart';
import '../pages/create_event_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      //home: CheckLogin(),
      home: CreateEventPage(title: 'Create',),
    );
  }
}
