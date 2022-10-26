import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/customer.dart';
import 'package:security_wanyu/model/home_screen_model.dart';
import 'package:security_wanyu/model/marquee_announcement.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/model/punch_card_record.dart';
import 'package:security_wanyu/model/user_location.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:security_wanyu/service/local_database.dart';

class HomeScreenBloc {
  final StreamController<HomeScreenModel> _streamController =
      StreamController();
  Stream<HomeScreenModel> get stream => _streamController.stream;
  HomeScreenModel _model = HomeScreenModel(userLocation: UserLocation());

  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;

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
      userLocation: _model.userLocation
          ?.copyWith(lat: position.latitude, lng: position.longitude),
    );
  }

  void _onServiceStatusUpdated(ServiceStatus serviceStatus) {
    updateWith(
        userLocation: _model.userLocation?.copyWith(
            locationServiceEnabled: serviceStatus == ServiceStatus.enabled));
  }

  Future<void> handleLocation() async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission != LocationPermission.always &&
        locationPermission != LocationPermission.whileInUse) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission != LocationPermission.always &&
          locationPermission != LocationPermission.whileInUse) {
        updateWith(
          userLocation:
              _model.userLocation?.copyWith(hasLocationPermission: false),
        );
      } else {
        updateWith(
          userLocation:
              _model.userLocation?.copyWith(hasLocationPermission: true),
        );
      }
    } else {
      _serviceStatusStreamSubscription?.cancel();
      _serviceStatusStreamSubscription =
          _serviceStatusStream().listen(_onServiceStatusUpdated);
      if (await Geolocator.isLocationServiceEnabled()) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription =
            _positionStream().listen(_onPositionUpdated, onError: (_) {});
        updateWith(
            userLocation: _model.userLocation?.copyWith(
          hasLocationPermission: true,
          locationServiceEnabled: true,
        ));
      } else {
        updateWith(
          userLocation: _model.userLocation?.copyWith(
            hasLocationPermission: true,
            locationServiceEnabled: false,
          ),
        );
      }
    }
  }

  late Timer uploadPatrolRecordTimer;

  Future<void> initialize({required Member member}) async {
    await handleLocation();
    if (await Utils.hasInternetConnection()) {
      List<Place2Patrol> places2Patrol = await EtunAPI.instance
          .getMemberPlaces2Patrol(memberName: member.memberName!);
      await LocalDatabase.instance
          .replacePlaces2Patrol(places2Patrol: places2Patrol);
      List<Customer> customers = await EtunAPI.instance.getCustomers();
      await LocalDatabase.instance.replaceCustomers(customers: customers);
    }
    uploadPatrolRecordTimer =
        Timer.periodic(const Duration(seconds: 10), (_) async {
      await LocalDatabase.instance.uploadLocalPunchCardRecords();
      await LocalDatabase.instance.uploadLocalPatrolRecords();
    });
  }

  Future<String> getMarqueeContent() async {
    if (await Utils.hasInternetConnection()) {
      MarqueeAnnouncement marqueeAnnouncement =
          await EtunAPI.instance.getMarqueeAnnouncement();
      return marqueeAnnouncement.content!;
    } else {
      return '目前為離線狀態';
    }
  }

  Future<void> workPunch({required Member member}) async {
    try {
      PunchCardRecord punchCardRecord = PunchCardRecord(
        memberId: member.memberId,
        memberSN: member.memberSN,
        memberName: member.memberName,
        punchCardType: PunchCards.work,
        lat: _model.userLocation?.lat,
        lng: _model.userLocation?.lng,
      );
      await LocalDatabase.instance.punchCard(punchCardRecord: punchCardRecord);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getOffPunch({required Member member}) async {
    try {
      PunchCardRecord punchCardRecord = PunchCardRecord(
        memberId: member.memberId,
        memberSN: member.memberSN,
        memberName: member.memberName,
        punchCardType: PunchCards.getOff,
        lat: 22.998020, //_model.userLocation?.lat,
        lng: 120.208535, // _model.userLocation?.lng,
      );
      await LocalDatabase.instance.punchCard(punchCardRecord: punchCardRecord);
    } catch (_) {
      rethrow;
    }
  }

  Future<int> getUpcomingPatrolCustomer({required int memberId}) async {
    try {
      int customerId = await LocalDatabase.instance.getUpcomingPatrolCustomer();
      return customerId;
    } catch (e) {
      rethrow;
    }
  }

  void updateWith({UserLocation? userLocation}) {
    _model = _model.copyWith(userLocation: userLocation);
    _streamController.add(_model);
  }

  void dispose() {
    uploadPatrolRecordTimer.cancel();
    _positionStreamSubscription?.cancel();
    _serviceStatusStreamSubscription?.cancel();
    _streamController.close();
  }
}
