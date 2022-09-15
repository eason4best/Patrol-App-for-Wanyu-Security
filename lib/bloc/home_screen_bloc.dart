import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/user_location_bloc.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/marquee_announcement.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/model/user_location.dart';
import 'package:security_wanyu/service/etun_api.dart';
import 'package:security_wanyu/service/local_database.dart';

class HomeScreenBloc {
  HomeScreenBloc();

  late Timer uploadPatrolRecordTimer;

  Future<void> initialize(
      {required Member member, required BuildContext context}) async {
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

  Future<void> workPunch(
      {required Member member, required UserLocation userLocation}) async {
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

  Future<void> getOffPunch(
      {required Member member, required UserLocation userLocation}) async {
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

  Future<int> getUpcomingPatrolCustomer({required int memberId}) async {
    try {
      int customerId =
          await EtunAPI.instance.getUpcomingPatrolCustomer(memberId: memberId);
      return customerId;
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    uploadPatrolRecordTimer.cancel();
  }
}
