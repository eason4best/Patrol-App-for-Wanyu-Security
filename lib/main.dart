import 'package:flutter/material.dart';
import 'package:security_wanyu/screen/home_screen.dart';

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
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade800,
          elevation: 0.0,
        ),
        primaryColor: Colors.grey,
        scaffoldBackgroundColor: const Color(0xfffafafa),
      ),
      home: HomeScreen.create(),
    );
  }
}
