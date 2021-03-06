import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ninja_trips/screens/login_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocuTo',
      home: LoginForm(),
    );
  }
}
