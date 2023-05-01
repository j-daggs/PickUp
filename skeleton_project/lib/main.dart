import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/check_user_login.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/classes/theme_class.dart';

void main() async {
  await GetStorage.init();
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
    return MaterialApp(
      theme: AppTheme.greenTheme,
      debugShowCheckedModeBanner: false,
      title: 'PickUP',
      home: const CheckLogin(),
    );
  }
}
