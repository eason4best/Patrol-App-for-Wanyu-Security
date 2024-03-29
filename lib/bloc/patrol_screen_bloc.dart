import 'dart:async';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/patrol_record.dart';
import 'package:security_wanyu/model/patrol_screen_model.dart';
import 'package:security_wanyu/model/place2patrol.dart';
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
  );
  PatrolScreenModel get model => _model;
  MobileScannerController scannerController = MobileScannerController();

  Future<void> initialize({required int customerId}) async {
    await updatePatrolPlaces(customerId: customerId);
  }

  Future<bool> patrol(
      {required Barcode barcode, required int customerId}) async {
    try {
      if (barcode.rawValue != null) {
        List<Place2Patrol> onDutyUndonePlaces2Patrol = _model
            .undonePlaces2Patrol!
            .where((pp) => pp.customerId == customerId)
            .toList();
        String? patrolPlaceSN = barcode.rawValue;
        int index = onDutyUndonePlaces2Patrol
            .indexWhere((upp) => upp.patrolPlaceSN == patrolPlaceSN);
        if (index != -1) {
          PatrolRecord patrolRecord = PatrolRecord(
            customerId: customerId,
            memberSN: member.memberSN,
            memberName: member.memberName,
            patrolPlaceSN: patrolPlaceSN,
            patrolPlaceTitle: onDutyUndonePlaces2Patrol[index].patrolPlaceTitle,
            patrolDateTime: DateTime.now(),
            day: DateTime.now().day,
          );
          await LocalDatabase.instance
              .insertPatrolRecord(patrolRecord: patrolRecord);
          await updatePatrolPlaces(customerId: customerId);
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

  Future<void> toggleTorch() async {
    if (scannerController.hasTorch) {
      await scannerController.toggleTorch();
      updateWith(torchOn: scannerController.torchState.value == TorchState.on);
    } else {
      throw Exception('沒有手電筒可開啟');
    }
  }

  Future<void> updatePatrolPlaces({required int customerId}) async {
    List<Place2Patrol> donePlaces2Patrol = await LocalDatabase.instance
        .getDonePlaces2Patrol(customerId: customerId);
    List<Place2Patrol> undonePlaces2Patrol = await LocalDatabase.instance
        .getUndonePlaces2Patrol(customerId: customerId);
    updateWith(
      donePlaces2Patrol: donePlaces2Patrol,
      undonePlaces2Patrol: undonePlaces2Patrol,
    );
  }

  bool completeAllPatrolPlaces() {
    return _model.undonePlaces2Patrol!.isEmpty;
  }

  void updateWith({
    List<Place2Patrol>? donePlaces2Patrol,
    List<Place2Patrol>? undonePlaces2Patrol,
    bool? torchOn,
  }) {
    _model = _model.copyWith(
      donePlaces2Patrol: donePlaces2Patrol,
      undonePlaces2Patrol: undonePlaces2Patrol,
      torchOn: torchOn,
    );
    _streamController.add(_model);
  }

  void dispose() {
    scannerController.dispose();
    _streamController.close();
  }
}
