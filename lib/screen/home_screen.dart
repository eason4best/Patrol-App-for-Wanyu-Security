import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/home_screen_bloc.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/api_exception.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/user_location.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/screen/contact_us_screen.dart';
import 'package:security_wanyu/screen/form_apply_screen.dart';
import 'package:security_wanyu/screen/makeup_screen.dart';
import 'package:security_wanyu/screen/onboard_screen.dart';
import 'package:security_wanyu/screen/patrol_screen.dart';
import 'package:security_wanyu/screen/shift_screen.dart';
import 'package:security_wanyu/screen/sos_screen.dart';
import 'package:security_wanyu/widget/announcement_marquee_widget.dart';
import 'package:security_wanyu/widget/location_request_banner.dart';
import 'package:security_wanyu/widget/main_function_widget.dart';
import 'package:security_wanyu/widget/punch_card_widget.dart';

class HomeScreen extends StatefulWidget {
  final HomeScreenBloc bloc;
  const HomeScreen({Key? key, required this.bloc}) : super(key: key);

  static Widget create() {
    return Provider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc(context: context),
      child: Consumer<HomeScreenBloc>(
        builder: (context, bloc, _) => HomeScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Member member;

  @override
  void initState() {
    member = Provider.of<Member>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歡迎使用 ${member.memberName}'),
        actions: [
          TextButton(
            onPressed: widget.bloc.signOut,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black54),
            ),
            child: const Text('登出'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
            future: widget.bloc.initialize(member: member, context: context),
            builder: (context, snapshot) {
              return Column(
                children: [
                  const LocationRequestBanner(),
                  AnnouncementMarqueeWidget(bloc: widget.bloc),
                  Container(
                    margin: const EdgeInsets.only(top: 36),
                    child: Text(
                      Utils.datetimeString(DateTime.now(),
                          onlyDate: true, showWeekday: true),
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(height: 1),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Text(
                      Utils.datetimeString(DateTime.now(), onlyTime: true),
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(height: 1),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => PunchCardWidget(
                          title: PunchCards.values
                              .map((pc) => pc.toString())
                              .toList()[index],
                          onPressed: PunchCards.values
                              .map((pc) => pc == PunchCards.work
                                  ? () => widget.bloc
                                      .workPunch(member: member)
                                      .then(
                                        (_) => showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('打卡成功'),
                                            content: const Text('上班打卡成功！'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  '確認',
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .catchError(
                                        (e) => showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text('打卡失敗'),
                                            content: Text(
                                              e is APIException
                                                  ? e.message
                                                  : '上班打卡失敗',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text(
                                                  '確認',
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  : pc == PunchCards.getOff
                                      ? () => widget.bloc
                                          .getOffPunch(member: member)
                                        ..then(
                                          (_) => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('打卡成功'),
                                              content: const Text('下班打卡成功！'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: const Text(
                                                    '確認',
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ).catchError(
                                          (e) => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('打卡失敗'),
                                              content: Text(
                                                e is APIException
                                                    ? e.message
                                                    : '下班打卡失敗',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: const Text(
                                                    '確認',
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) =>
                                                  MakeUpScreen.create(
                                                      member: member),
                                            ),
                                          ))
                              .toList()[index],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: GridView(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 30,
                        childAspectRatio: 3 / 4,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MainFunctionWidget(
                          title: '巡邏',
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            size: 48,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            UserLocation userLocation =
                                Provider.of<UserLocation>(context,
                                    listen: false);
                            if (!userLocation.hasLocationPermission!) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('請開啟定位權限'),
                                behavior: SnackBarBehavior.floating,
                              ));
                            } else if (!userLocation.locationServiceEnabled!) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('請開啟手機定位功能'),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                            widget.bloc
                                .getUpcomingPatrolCustomer(
                                    memberId: member.memberId!)
                                .then(
                                  (customerId) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PatrolScreen.create(member: member),
                                    ),
                                  ),
                                )
                                .catchError(
                                  (e) => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('無法開始巡邏'),
                                      content: Text(
                                        e is APIException ? e.message : '發生錯誤',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text(
                                            '確認',
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                          },
                        ),
                        MainFunctionWidget(
                          title: '班表',
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 48,
                            color: Colors.black87,
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShiftScreen(),
                          )),
                        ),
                        MainFunctionWidget(
                          title: '緊急連絡',
                          icon: const Icon(
                            Icons.sos_outlined,
                            size: 48,
                            color: Colors.black87,
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SOSScreen(),
                          )),
                        ),
                        MainFunctionWidget(
                          title: '辦理入職',
                          icon: const Icon(
                            Icons.badge_outlined,
                            size: 48,
                            color: Colors.black87,
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OnBoardScreen(
                              member: member,
                            ),
                          )),
                        ),
                        MainFunctionWidget(
                          title: '表單申請',
                          icon: const Icon(
                            Icons.description_outlined,
                            size: 48,
                            color: Colors.black87,
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FormApplyScreen(
                              member: member,
                            ),
                          )),
                        ),
                        MainFunctionWidget(
                          title: '聯絡我們',
                          icon: const Icon(
                            Icons.call_outlined,
                            size: 48,
                            color: Colors.black87,
                          ),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ContactUsScreen(),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
