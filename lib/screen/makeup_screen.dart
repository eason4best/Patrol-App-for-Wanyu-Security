import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/make_up_screen_bloc.dart';
import 'package:security_wanyu/enum/punch_cards.dart';
import 'package:security_wanyu/model/make_up_screen_model.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/other/utils.dart';

class MakeUpScreen extends StatelessWidget {
  final MakeUpScreenBloc bloc;
  const MakeUpScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create({required Member member}) {
    return Provider<MakeUpScreenBloc>(
      create: (context) => MakeUpScreenBloc(member: member),
      child: Consumer<MakeUpScreenBloc>(
        builder: (context, bloc, _) => MakeUpScreen(
          bloc: bloc,
        ),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('補卡'),
      ),
      body: StreamBuilder<MakeUpScreenModel>(
          stream: bloc.stream,
          initialData: bloc.model,
          builder: (context, snapshot) {
            return Column(
              children: [
                RadioListTile<PunchCards>(
                  value: PunchCards.work,
                  groupValue: snapshot.data!.type!,
                  onChanged: bloc.selecPunchCardType,
                  tileColor: Colors.white,
                  title: const Text('上班'),
                  contentPadding: const EdgeInsets.only(left: 8),
                ),
                RadioListTile<PunchCards>(
                  value: PunchCards.getOff,
                  groupValue: snapshot.data!.type!,
                  onChanged: bloc.selecPunchCardType,
                  tileColor: Colors.white,
                  title: const Text('下班'),
                  contentPadding: const EdgeInsets.only(left: 8),
                ),
                Divider(
                  thickness: 1,
                  height: 0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: const Icon(Icons.schedule_outlined),
                  title: GestureDetector(
                    onTap: () async => await bloc.pickDate(context),
                    child: Text(Utils.datetimeString(
                      snapshot.data!.dateTime!,
                      onlyDate: true,
                      showWeekday: true,
                    )),
                  ),
                  trailing: GestureDetector(
                    onTap: () async => await bloc.pickTime(context),
                    child: Text(
                      Utils.datetimeString(
                        snapshot.data!.dateTime!,
                        onlyTime: true,
                      ),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading: const Icon(Icons.location_on_outlined),
                  title: SizedBox(
                    height: 48,
                    child: TextField(
                      controller: bloc.placeController,
                      onChanged: bloc.onInputPlace,
                      decoration: const InputDecoration(
                        hintText: '請輸入地點',
                        contentPadding: EdgeInsets.all(0),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 56,
                  margin: const EdgeInsets.only(top: 32),
                  child: ElevatedButton(
                    onPressed: snapshot.data!.canSubmit!
                        ? () async => await bloc.submit(context)
                        : null,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0.0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Center(child: Text('確認')),
                  ),
                )
              ],
            );
          }),
    );
  }
}
