import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class StartPatrolScreenBloc {
  final BuildContext context;
  late MobileScannerController _scannerController;
  StartPatrolScreenBloc({required this.context}) {
    _scannerController = MobileScannerController();
  }

  MobileScannerController get scannerController => _scannerController;

  void onDetect(Barcode barcode, MobileScannerArguments? args) {
    if (barcode.rawValue != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('掃描成功：${barcode.rawValue}'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  void dispose() {
    _scannerController.dispose();
  }
}
