import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/screen/confirm_patrol_screen.dart';
import 'package:security_wanyu/screen/offline_patrol_screen.dart';
import 'package:security_wanyu/screen/patrol_record_screen.dart';
import 'package:security_wanyu/screen/upload_image_screen.dart';

class HomeScreenBloc {
  final BuildContext context;
  HomeScreenBloc({required this.context});

  VoidCallback onItemPressed(MainFunctions mainFunction) {
    switch (mainFunction) {
      case MainFunctions.startPatrol:
        return () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Container()));
      case MainFunctions.patrolRecord:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PatrolRecordScreen(),
            ));
      case MainFunctions.patrolComfirm:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ConfirmPatrolScreen(),
            ));
      case MainFunctions.offlinePatrol:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const OfflinePatrolScreen(),
            ));
      case MainFunctions.uploadImage:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UploadImageScreen(),
            ));
      case MainFunctions.signOut:
        return () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Container()));
    }
  }

  void dispose() {}
}
