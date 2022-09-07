import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:security_wanyu/model/user_location.dart';

class UserLocationBloc {
  UserLocationBloc() {
    _positionStreamSubscription =
        _positionStream().listen(_onPositionUpdated, onError: (_) {});
    _serviceStatusStreamSubscription =
        _serviceStatusStream().listen(_onServiceStatusUpdated);
    Geolocator.isLocationServiceEnabled().then((locationServiceEnabled) =>
        updateWith(locationServiceEnabled: locationServiceEnabled));
  }
  late StreamSubscription<Position> _positionStreamSubscription;
  late StreamSubscription<ServiceStatus> _serviceStatusStreamSubscription;
  final StreamController<UserLocation> _streamController = StreamController();
  Stream<UserLocation> get stream => _streamController.stream;
  UserLocation _model = UserLocation(
    lat: 0,
    lng: 0,
    locationServiceEnabled: false,
    hasLocationPermission: false,
  );
  UserLocation get model => _model;

  Stream<Position> _positionStream() {
    LocationSettings locationSettings =
        const LocationSettings(distanceFilter: 0);
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Stream<ServiceStatus> _serviceStatusStream() {
    return Geolocator.getServiceStatusStream();
  }

  void _onPositionUpdated(Position position) {
    updateWith(
      lat: position.latitude,
      lng: position.longitude,
    );
  }

  void _onServiceStatusUpdated(ServiceStatus serviceStatus) {
    updateWith(locationServiceEnabled: serviceStatus == ServiceStatus.enabled);
  }

  Future<void> handleLocationPermission() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission != LocationPermission.always &&
        locationPermission != LocationPermission.whileInUse) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission != LocationPermission.always &&
          locationPermission != LocationPermission.whileInUse) {
        updateWith(hasLocationPermission: false);
      } else {
        updateWith(hasLocationPermission: true);
      }
    } else {
      updateWith(hasLocationPermission: true);
    }
  }

  void updateWith({
    double? lat,
    double? lng,
    bool? locationServiceEnabled,
    bool? hasLocationPermission,
  }) {
    _model = _model.copyWith(
      lat: lat,
      lng: lng,
      locationServiceEnabled: locationServiceEnabled,
      hasLocationPermission: hasLocationPermission,
    );
    _streamController.add(_model);
  }

  void dispose() {
    _positionStreamSubscription.cancel();
    _serviceStatusStreamSubscription.cancel();
    _streamController.close();
  }
}
