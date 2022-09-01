import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:security_wanyu/bloc/user_location_bloc.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/user_location.dart';
import 'package:security_wanyu/screen/contact_us_screen.dart';
import 'package:security_wanyu/screen/login_screen.dart';
import 'package:security_wanyu/screen/sos_screen.dart';
import 'package:security_wanyu/screen/onboard_screen.dart';
import 'package:security_wanyu/screen/shift_screen.dart';
import 'package:security_wanyu/screen/patrol_screen.dart';
import 'package:security_wanyu/screen/form_apply_screen.dart';
import 'package:security_wanyu/service/etun_api.dart';

class HomeScreenBloc {
  final Member member;
  final BuildContext context;
  HomeScreenBloc({
    required this.member,
    required this.context,
  });

  Future<void> initialize({
    required UserLocationBloc userLocationBloc,
    required BuildContext context,
  }) async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        userLocationBloc.updateLocationPermission(hasLocationPermission: false);
      }
    } else if (locationPermission == LocationPermission.deniedForever) {
      userLocationBloc.updateLocationPermission(hasLocationPermission: false);
    } else {
      userLocationBloc.updateLocationPermission(hasLocationPermission: true);
    }
  }

  Future<void> workPunch({required UserLocation userLocation}) async {
    bool result = await EtunAPI.punchCard(
      type: PunchCards.work,
      member: member,
      lat: userLocation.lat,
      lng: userLocation.lng,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result ? '打卡成功！' : '打卡失敗'),
        content: Text(result ? '上班打卡成功！' : '上班打卡失敗，請再試一次。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              '確認',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getOffPunch({required UserLocation userLocation}) async {
    bool result = await EtunAPI.punchCard(
      type: PunchCards.getOff,
      member: member,
      lat: userLocation.lat,
      lng: userLocation.lng,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result ? '打卡成功！' : '打卡失敗'),
        content: Text(result ? '下班打卡成功！' : '下班打卡失敗，請再試一次。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              '確認',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  VoidCallback onMainFunctionsPressed(MainFunctions mainFunction) {
    switch (mainFunction) {
      case MainFunctions.startPatrol:
        return () => Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => PatrolScreen.create(),
            ));
      case MainFunctions.shift:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ShiftScreen(),
            ));
      case MainFunctions.sos:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SOSScreen(),
            ));
      case MainFunctions.onboard:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const OnBoardScreen(),
            ));
      case MainFunctions.formApply:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FormApplyScreen(member: member),
            ));
      case MainFunctions.contactUs:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ContactUsScreen(),
            ));
    }
  }

  Icon getMainFunctionsIcon(MainFunctions mainFunction) {
    switch (mainFunction) {
      case MainFunctions.startPatrol:
        return const Icon(
          Icons.qr_code_scanner,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.shift:
        return const Icon(
          Icons.calendar_month_outlined,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.sos:
        return const Icon(
          Icons.sos_outlined,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.onboard:
        return const Icon(
          Icons.badge_outlined,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.formApply:
        return const Icon(
          Icons.description_outlined,
          size: 48,
          color: Colors.black87,
        );
      case MainFunctions.contactUs:
        return const Icon(
          Icons.call_outlined,
          size: 48,
          color: Colors.black87,
        );
    }
  }

  void signOut() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen.create()));
  }

  void dispose() {}
}
