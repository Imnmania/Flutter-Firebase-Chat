import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase_2/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        centerTitle: true,
      ),
      body: Center(
        child: FlatButton(
          color: Colors.red,
          child: Text(
            'Sign in with Google',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          onPressed: () {
            AuthMethods().signInWithGoogle(context);
          },
        ),
      ),
    );
  }
}
