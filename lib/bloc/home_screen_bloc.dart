import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/screen/confirm_patrol_screen.dart';
import 'package:security_wanyu/screen/offline_patrol_screen.dart';
import 'package:security_wanyu/screen/patrol_record_screen.dart';
import 'package:security_wanyu/screen/start_patrol_screen.dart';
import 'package:security_wanyu/screen/upload_image_screen.dart';

class HomeScreenBloc {
  final BuildContext context;
  HomeScreenBloc({required this.context});

  VoidCallback onItemPressed(MainFunctions mainFunction) {
    switch (mainFunction) {
      case MainFunctions.startPatrol:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StartPatrolScreen.create(),
            ));
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
              builder: (context) => OfflinePatrolScreen.create(),
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

  Icon getIcon(MainFunctions mainFunction) {
    switch (mainFunction) {
      case MainFunctions.startPatrol:
        return const Icon(
          Icons.qr_code_scanner,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.patrolRecord:
        return const Icon(
          Icons.history,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.patrolComfirm:
        return const Icon(
          Icons.check_circle_outline,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.offlinePatrol:
        return const Icon(
          Icons.wifi_off,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.uploadImage:
        return const Icon(
          Icons.upload,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.signOut:
        return const Icon(
          Icons.exit_to_app,
          size: 48,
          color: Colors.black87,
        );
    }
  }

  void dispose() {}
}
