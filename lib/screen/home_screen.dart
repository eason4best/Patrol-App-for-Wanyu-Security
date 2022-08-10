import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/home_screen_bloc.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/widget/home_screen_item.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenBloc bloc;
  const HomeScreen({Key? key, required this.bloc}) : super(key: key);

  static Widget create() {
    return Provider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc(context: context),
      child: Consumer<HomeScreenBloc>(
        builder: (context, bloc, _) => HomeScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

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
          onItemPressed: MainFunctions.values
              .map((f) => bloc.onItemPressed(f))
              .toList()[index],
        ),
      ),
    );
  }
}
