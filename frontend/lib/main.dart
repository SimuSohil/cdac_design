import 'package:cdac_design/authentication/login_page.dart';
import 'package:cdac_design/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'phone_state_background_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    _initializePhoneStateBackground();
  }

  Future<void> _initializePhoneStateBackground() async {
    await PhoneStateBackgroundHandler.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti-Vishing Application',
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}