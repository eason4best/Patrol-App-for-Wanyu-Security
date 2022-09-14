import 'package:security_wanyu/model/place2patrol.dart';

class PatrolScreenModel {
  final List<Place2Patrol>? places2patrol;
  final bool? torchOn;
  final bool? offline;

  PatrolScreenModel({
    this.places2patrol,
    this.torchOn,
    this.offline,
  });

  PatrolScreenModel copyWith({
    List<Place2Patrol>? places2patrol,
    bool? torchOn,
    bool? offline,
  }) {
    return PatrolScreenModel(
      places2patrol: places2patrol ?? this.places2patrol,
      torchOn: torchOn ?? this.torchOn,
      offline: offline ?? this.offline,
    );
  }
}
