import 'dart:async';

import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/model/shift_screen_model.dart';
import 'package:security_wanyu/service/local_database.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShiftScreenBloc {
  final StreamController<ShiftScreenModel> _streamController =
      StreamController();
  Stream<ShiftScreenModel> get stream => _streamController.stream;
  ShiftScreenModel _model = ShiftScreenModel(
    selectedDate: DateTime.now(),
    places2Patrol: [],
  );
  ShiftScreenModel get model => _model;
  final CalendarController calendarController = CalendarController();

  Future<void> initialize() async {
    List<Place2Patrol> places2Patrol =
        await LocalDatabase.instance.getPlaces2Patrol();
    updateWith(places2Patrol: places2Patrol);
  }

  void onSelectDate(CalendarSelectionDetails calendarSelectionDetails) {
    if (calendarSelectionDetails.date!.month == _model.selectedDate!.month) {
      updateWith(selectedDate: calendarSelectionDetails.date);
    }
  }

  void updateWith({
    DateTime? selectedDate,
    List<Place2Patrol>? places2Patrol,
  }) {
    _model = _model.copyWith(
        selectedDate: selectedDate, places2Patrol: places2Patrol);
    _streamController.add(_model);
  }

  void dispose() {
    calendarController.dispose();
    _streamController.close();
  }
}
