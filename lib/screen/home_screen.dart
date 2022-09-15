import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/home_screen_bloc.dart';
import 'package:security_wanyu/enum/main_functions.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/api_exception.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/screen/makeup_screen.dart';
import 'package:security_wanyu/widget/announcement_marquee_widget.dart';
import 'package:security_wanyu/widget/location_request_banner.dart';
import 'package:security_wanyu/widget/main_function_widget.dart';
import 'package:security_wanyu/widget/punch_card_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenBloc bloc;
  const HomeScreen({Key? key, required this.bloc}) : super(key: key);

  static Widget create() {
    return Provider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc(
          member: Provider.of<Member>(context, listen: false),
          context: context),
      child: Consumer<HomeScreenBloc>(
        builder: (context, bloc, _) => HomeScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歡迎使用 ${bloc.member.memberName}'),
        actions: [
          TextButton(
            onPressed: bloc.signOut,
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black54),
            ),
            child: const Text('登出'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
            future: bloc.initialize(context: context),
            builder: (context, snapshot) {
              return Column(
                children: [
                  const LocationRequestBanner(),
                  AnnouncementMarqueeWidget(bloc: bloc),
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
                                  ? () => bloc
                                      .workPunch()
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
                                      ? () => bloc.getOffPunch()
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
                                                      member: bloc.member),
                                            ),
                                          ))
                              .toList()[index],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: GridView.builder(
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
                      itemCount: MainFunctions.values.length,
                      itemBuilder: (context, index) => MainFunctionWidget(
                        title: MainFunctions.values
                            .map((f) => f.toString())
                            .toList()[index],
                        icon: MainFunctions.values
                            .map((f) => bloc.getMainFunctionsIcon(f))
                            .toList()[index],
                        onPressed: MainFunctions.values
                            .map((f) => bloc.onMainFunctionsPressed(f))
                            .toList()[index],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
