import 'package:flutter/material.dart';
import 'package:cdac_design/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  String _email = '';
  String _password = '';

  void login() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    log('email: $_email');
    log('password: $_password');

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      log('login successful: ${userCredential.user?.email}');

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    } catch (e) {
      log('error: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('login failed: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 113, 136, 204),
      appBar: AppBar(
        backgroundColor: const Color(0xff4E66AB),
        title: const Text(
          'Anti-Vishing Application',
          style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xffFFFFFF)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff4E66AB), Color(0xffFFFFFF)
            ]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                height: 50,
                child: Text(
                  'Login Page',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  filled: true,
                  fillColor: Color(0xffFFFFFF)
                ),
              ),
              SizedBox(
                height: 10,
                width: MediaQuery.of(context).size.width,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: const Color(0xffFFFFFF),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }, 
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off
                    )
                  )
                ),
                obscureText: !_isPasswordVisible,
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4E66AB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)
                    )
                  ),
                  onPressed: login, 
                  child: const Text(
                    'login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}