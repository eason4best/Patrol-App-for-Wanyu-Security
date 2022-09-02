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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          '巡邏成功',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  void dispose() {
    _scannerController.dispose();
  }
}
