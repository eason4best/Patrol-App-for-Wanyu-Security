import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/user_location_bloc.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/marquee_announcement.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/model/user_location.dart';
import 'package:security_wanyu/screen/contact_us_screen.dart';
import 'package:security_wanyu/screen/login_screen.dart';
import 'package:security_wanyu/screen/sos_screen.dart';
import 'package:security_wanyu/screen/onboard_screen.dart';
import 'package:security_wanyu/screen/shift_screen.dart';
import 'package:security_wanyu/screen/patrol_screen.dart';
import 'package:security_wanyu/screen/form_apply_screen.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:security_wanyu/service/local_database.dart';

class HomeScreenBloc {
  final Member member;
  final BuildContext context;
  HomeScreenBloc({
    required this.member,
    required this.context,
  });

  late Timer uploadPatrolRecordTimer;

  Future<void> initialize({required BuildContext context}) async {
    await Provider.of<UserLocationBloc>(context, listen: false)
        .handleLocationPermission();
    List<Place2Patrol> places2Patrol = await EtunAPI.instance
        .getMemberPlaces2Patrol(memberName: member.memberName!);
    await LocalDatabase.instance
        .replaceAllPlaces2Patrol(places2Patrol: places2Patrol);
    uploadPatrolRecordTimer =
        Timer.periodic(const Duration(seconds: 10), (_) async {});
  }

  Future<String> getMarqueeContent() async {
    MarqueeAnnouncement marqueeAnnouncement =
        await EtunAPI.instance.getMarqueeAnnouncement();
    return marqueeAnnouncement.content!;
  }

  Future<void> workPunch() async {
    UserLocation userLocation =
        Provider.of<UserLocation>(context, listen: false);
    if (!userLocation.hasLocationPermission!) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('請開啟定位權限'),
        behavior: SnackBarBehavior.floating,
      ));
    } else if (!userLocation.locationServiceEnabled!) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('請開啟手機定位功能'),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      try {
        await EtunAPI.instance.punchCard(
          type: PunchCards.work,
          member: member,
          lat: userLocation.lat,
          lng: userLocation.lng,
        );
      } catch (_) {
        rethrow;
      }
    }
  }

  Future<void> getOffPunch() async {
    UserLocation userLocation =
        Provider.of<UserLocation>(context, listen: false);
    if (!userLocation.hasLocationPermission!) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('請開啟定位權限'),
        behavior: SnackBarBehavior.floating,
      ));
    } else if (!userLocation.locationServiceEnabled!) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('請開啟手機定位功能'),
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      try {
        await EtunAPI.instance.punchCard(
          type: PunchCards.getOff,
          member: member,
          lat: userLocation.lat,
          lng: userLocation.lng,
        );
      } catch (_) {
        rethrow;
      }
    }
  }

  VoidCallback onMainFunctionsPressed(MainFunctions mainFunction) {
    switch (mainFunction) {
      case MainFunctions.startPatrol:
        return () {
          UserLocation userLocation =
              Provider.of<UserLocation>(context, listen: false);
          if (!userLocation.hasLocationPermission!) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('請開啟定位權限'),
              behavior: SnackBarBehavior.floating,
            ));
          } else if (!userLocation.locationServiceEnabled!) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('請開啟手機定位功能'),
              behavior: SnackBarBehavior.floating,
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => PatrolScreen.create(member: member),
            ));
          }
        };
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
              builder: (context) => OnBoardScreen(member: member),
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

  void dispose() {
    uploadPatrolRecordTimer.cancel();
  }
}
