import 'package:flutter/material.dart';
import 'package:security_wanyu/screen/start_patrol_screen.dart';

class OfflinePatrolScreenBloc {
  final BuildContext context;
  OfflinePatrolScreenBloc({required this.context});
  void offlinePatrol() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => StartPatrolScreen.create()));
  }

  void dispose() {}
}
