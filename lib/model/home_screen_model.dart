import 'package:security_wanyu/model/user_location.dart';

class HomeScreenModel {
  UserLocation? userLocation;
  bool get canGetLocation =>
      userLocation!.hasLocationPermission! &&
      userLocation!.locationServiceEnabled!;
  HomeScreenModel({this.userLocation});

  HomeScreenModel copyWith({
    UserLocation? userLocation,
    bool? showLocationDialog,
  }) {
    return HomeScreenModel(userLocation: userLocation ?? this.userLocation);
  }
}
