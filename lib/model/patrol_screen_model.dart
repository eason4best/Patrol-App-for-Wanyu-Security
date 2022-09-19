import 'package:security_wanyu/model/place2patrol.dart';

class PatrolScreenModel {
  final List<Place2Patrol>? donePlaces2Patrol;
  final List<Place2Patrol>? undonePlaces2Patrol;
  final bool? torchOn;

  PatrolScreenModel({
    this.donePlaces2Patrol,
    this.undonePlaces2Patrol,
    this.torchOn,
  });

  PatrolScreenModel copyWith({
    List<Place2Patrol>? donePlaces2Patrol,
    List<Place2Patrol>? undonePlaces2Patrol,
    bool? torchOn,
  }) {
    return PatrolScreenModel(
      donePlaces2Patrol: donePlaces2Patrol ?? this.donePlaces2Patrol,
      undonePlaces2Patrol: undonePlaces2Patrol ?? this.undonePlaces2Patrol,
      torchOn: torchOn ?? this.torchOn,
    );
  }
}
