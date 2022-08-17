import 'package:flutter/material.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/screen/contact_us_screen.dart';
import 'package:security_wanyu/screen/sos_screen.dart';
import 'package:security_wanyu/screen/onboard_screen.dart';
import 'package:security_wanyu/screen/shift_screen.dart';
import 'package:security_wanyu/screen/start_patrol_screen.dart';
import 'package:security_wanyu/screen/form_apply_screen.dart';

class HomeScreenBloc {
  final BuildContext context;
  HomeScreenBloc({required this.context});

  String currentDateString() {
    final currentDate = DateTime.now();
    final year = currentDate.year;
    final month = currentDate.month;
    final day = currentDate.day;
    final weekday = currentDate.weekday;
    const weekdayInCH = ['ㄧ', '二', '三', '四', '五', '六', '日'];
    return '$year年$month月$day日 星期${weekdayInCH[weekday - 1]}';
  }

  String currentTimeString() {
    final currentDate = DateTime.now();
    final hour =
        currentDate.hour < 10 ? '0${currentDate.hour}' : currentDate.hour;
    final minute =
        currentDate.minute < 10 ? '0${currentDate.minute}' : currentDate.minute;
    return '$hour:$minute';
  }

  VoidCallback onPunchCardsPressed(PunchCards punchCards) {
    switch (punchCards) {
      case PunchCards.work:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Container(),
            ));
      case PunchCards.getOff:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Container(),
            ));
      case PunchCards.makeUp:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Container(),
            ));
    }
  }

  VoidCallback onMainFunctionsPressed(MainFunctions mainFunction) {
    switch (mainFunction) {
      case MainFunctions.startPatrol:
        return () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StartPatrolScreen.create(),
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
              builder: (context) => const FormApplyScreen(),
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

  void signOut() {}

  void dispose() {}
}
