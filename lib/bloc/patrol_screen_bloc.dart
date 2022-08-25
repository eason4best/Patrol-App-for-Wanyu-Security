import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PatrolScreenBloc {
  final BuildContext context;
  late MobileScannerController _scannerController;
  PatrolScreenBloc({required this.context}) {
    _scannerController = MobileScannerController();
  }

  MobileScannerController get scannerController => _scannerController;

  void onDetect(Barcode barcode, MobileScannerArguments? args) {
    if (barcode.rawValue != null) {
      Flushbar(
        message: '巡邏成功',
        duration: const Duration(seconds: 2),
        messageSize: 16.0,
        flushbarPosition: FlushbarPosition.TOP,
      ).show(context);
    }
  }

  void dispose() {
    _scannerController.dispose();
  }
}
