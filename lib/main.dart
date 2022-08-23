import 'package:flutter/material.dart';
import 'package:security_wanyu/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '萬宇保全[員]',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black87,
          elevation: 0.0,
        ),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.cyan.shade50,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen.create(),
    );
  }
}
