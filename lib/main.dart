import 'package:batch_a_29_dec/screen/home_page.dart';
import 'package:batch_a_29_dec/screen/log_in.dart';
import 'package:batch_a_29_dec/screen/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          FirebaseAuth.instance.currentUser==null?
      LogIn():
      HomePage(),
    );
  }
}
