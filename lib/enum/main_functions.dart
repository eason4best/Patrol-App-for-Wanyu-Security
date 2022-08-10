import 'package:flutter/material.dart';

enum MainFunctions {
  startPatrol,
  patrolRecord,
  patrolComfirm,
  offlinePatrol,
  uploadImage,
  signOut;

  @override
  String toString() {
    switch (this) {
      case MainFunctions.startPatrol:
        return '開始巡邏';
      case MainFunctions.patrolRecord:
        return '巡邏紀錄';
      case MainFunctions.patrolComfirm:
        return '巡邏確認';
      case MainFunctions.offlinePatrol:
        return '離線巡邏';
      case MainFunctions.uploadImage:
        return '上傳圖片資料';
      case MainFunctions.signOut:
        return '登出';
    }
  }

  Icon getIcon() {
    switch (this) {
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
}
