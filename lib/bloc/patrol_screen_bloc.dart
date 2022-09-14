import 'dart:async';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/patrol_record.dart';
import 'package:security_wanyu/model/patrol_screen_model.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/service/local_database.dart';

class PatrolScreenBloc {
  final Member member;
  PatrolScreenBloc({required this.member});
  final StreamController<PatrolScreenModel> _streamController =
      StreamController();
  Stream<PatrolScreenModel> get stream => _streamController.stream;
  PatrolScreenModel _model = PatrolScreenModel(
    donePlaces2Patrol: [],
    undonePlaces2Patrol: [],
    torchOn: false,
    offline: false,
  );
  PatrolScreenModel get model => _model;
  MobileScannerController scannerController = MobileScannerController();

  Future<void> initialize() async {
    await updatePatrolPlaces();
    bool offline = !await Utils.hasInternetConnection();
    updateWith(
      offline: offline,
    );
  }

  Future<bool> patrol({required Barcode barcode}) async {
    try {
      if (barcode.rawValue != null) {
        String? patrolPlaceSN = barcode.rawValue;
        int? customerId = _model.undonePlaces2Patrol!
            .firstWhere((upp) => upp.patrolPlaceSN == patrolPlaceSN)
            .customerId;
        String? patrolPlaceTitle = _model.undonePlaces2Patrol!
            .firstWhere((upp) => upp.patrolPlaceSN == patrolPlaceSN)
            .patrolPlaceTitle;
        if (customerId != null && patrolPlaceTitle != null) {
          PatrolRecord patrolRecord = PatrolRecord(
            customerId: customerId,
            memberSN: member.memberSN,
            memberName: member.memberName,
            patrolPlaceSN: patrolPlaceSN,
            patrolPlaceTitle: patrolPlaceTitle,
            day: DateTime.now().day,
          );
          await LocalDatabase.instance
              .insertPatrolRecord(patrolRecord: [patrolRecord]);
          await updatePatrolPlaces();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePatrolPlaces() async {
    List<Place2Patrol> donePlaces2Patrol =
        await LocalDatabase.instance.getDonePlaces2Patrol();
    List<Place2Patrol> undonePlaces2Patrol =
        await LocalDatabase.instance.getUndonePlaces2Patrol();
    updateWith(
      donePlaces2Patrol: donePlaces2Patrol,
      undonePlaces2Patrol: undonePlaces2Patrol,
    );
  }

  void updateWith({
    List<Place2Patrol>? donePlaces2Patrol,
    List<Place2Patrol>? undonePlaces2Patrol,
    bool? torchOn,
    bool? offline,
  }) {
    _model = _model.copyWith(
      donePlaces2Patrol: donePlaces2Patrol,
      undonePlaces2Patrol: undonePlaces2Patrol,
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
