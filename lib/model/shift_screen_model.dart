import 'package:security_wanyu/model/place2patrol.dart';

class ShiftScreenModel {
  final DateTime? selectedDate;
  final List<Place2Patrol>? places2Patrol;
  ShiftScreenModel({
    this.selectedDate,
    this.places2Patrol,
  });

  ShiftScreenModel copyWith({
    DateTime? selectedDate,
    List<Place2Patrol>? places2Patrol,
  }) {
    return ShiftScreenModel(
      selectedDate: selectedDate ?? this.selectedDate,
      places2Patrol: places2Patrol ?? this.places2Patrol,
    );
  }
}
