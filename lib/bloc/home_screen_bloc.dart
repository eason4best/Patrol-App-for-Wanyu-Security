import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/user_location_bloc.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/customer.dart';
import 'package:security_wanyu/model/marquee_announcement.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:security_wanyu/model/punch_card_record.dart';
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
        .replacePlaces2Patrol(places2Patrol: places2Patrol);
    List<Customer> customers = await EtunAPI.instance.getCustomers();
    await LocalDatabase.instance.replaceCustomers(customers: customers);
    uploadPatrolRecordTimer =
        Timer.periodic(const Duration(seconds: 10), (_) async {
      await LocalDatabase.instance.uploadLocalPunchCardRecords();
      await LocalDatabase.instance.uploadLocalPatrolRecords();
    });
  }

  Future<String> getMarqueeContent() async {
    MarqueeAnnouncement marqueeAnnouncement =
        await EtunAPI.instance.getMarqueeAnnouncement();
    return marqueeAnnouncement.content!;
  }

  Future<void> workPunch(
      {required Member member, required UserLocation userLocation}) async {
    try {
      PunchCardRecord punchCardRecord = PunchCardRecord(
        memberId: member.memberId,
        memberSN: member.memberSN,
        memberName: member.memberName,
        punchCardType: PunchCards.work,
        lat: userLocation.lat,
        lng: userLocation.lng,
      );
      await LocalDatabase.instance.punchCard(punchCardRecord: punchCardRecord);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> getOffPunch(
      {required Member member, required UserLocation userLocation}) async {
    try {
      PunchCardRecord punchCardRecord = PunchCardRecord(
        memberId: member.memberId,
        memberSN: member.memberSN,
        memberName: member.memberName,
        punchCardType: PunchCards.getOff,
        lat: userLocation.lat,
        lng: userLocation.lng,
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

  void dispose() {
    uploadPatrolRecordTimer.cancel();
  }
}
