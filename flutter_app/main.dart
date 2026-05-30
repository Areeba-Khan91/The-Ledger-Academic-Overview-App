import 'package:flutter/material.dart';
import 'package:flutter_app/views/login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const LoginScreen(),
  ));
}