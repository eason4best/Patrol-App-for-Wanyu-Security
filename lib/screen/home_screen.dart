import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/widget/home_screen_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('萬宇保全[員]'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 4,
        ),
        itemCount: MainFunctions.values.length,
        itemBuilder: (context, index) => HomeScreenItem(
          title: MainFunctions.values.map((f) => f.toString()).toList()[index],
          icon: MainFunctions.values.map((f) => f.getIcon()).toList()[index],
        ),
      ),
    );
  }
}
