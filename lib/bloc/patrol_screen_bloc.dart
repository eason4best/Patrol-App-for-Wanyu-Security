import 'dart:async';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:security_wanyu/model/patrol_screen_model.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/service/local_database.dart';

class PatrolScreenBloc {
  final StreamController<PatrolScreenModel> _streamController =
      StreamController();
  Stream<PatrolScreenModel> get stream => _streamController.stream;
  PatrolScreenModel _model = PatrolScreenModel(
    places2patrol: [],
    torchOn: false,
    offline: false,
  );
  PatrolScreenModel get model => _model;
  MobileScannerController scannerController = MobileScannerController();

  Future<void> initialize() async {
    List<Place2Patrol> places2Patrol =
        await LocalDatabase.instance.getPlaces2Patrol();
    bool offline = !await Utils.hasInternetConnection();
    updateWith(places2patrol: places2Patrol, offline: offline);
  }

  void updateWith({
    List<Place2Patrol>? places2patrol,
    bool? torchOn,
    bool? offline,
  }) {
    _model = _model.copyWith(
      places2patrol: places2patrol,
      torchOn: torchOn,
      offline: offline,
    );
    _streamController.add(_model);
  }

  void dispose() {
    scannerController.dispose();
    _streamController.close();
  }
}
