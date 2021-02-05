import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase_2/views/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SignIn(),
    );
  }
}
