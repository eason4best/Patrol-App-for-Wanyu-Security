import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/start_patrol_screen_bloc.dart';
import 'package:security_wanyu/widget/scan_frame.dart';

class StartPatrolScreen extends StatelessWidget {
  final StartPatrolScreenBloc bloc;
  const StartPatrolScreen({Key? key, required this.bloc}) : super(key: key);

  static Widget create() {
    return Provider<StartPatrolScreenBloc>(
      create: (context) => StartPatrolScreenBloc(context: context),
      child: Consumer<StartPatrolScreenBloc>(
        builder: (context, bloc, _) => StartPatrolScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: bloc.scannerController,
            onDetect: bloc.onDetect,
          ),
          const Scanframe(),
        ],
      ),
    );
  }
}
