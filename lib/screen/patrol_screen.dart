import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/patrol_screen_bloc.dart';
import 'package:security_wanyu/model/member.dart';
import 'package:security_wanyu/model/patrol_screen_model.dart';
import 'package:security_wanyu/screen/patrol_record_screen.dart';
import 'package:security_wanyu/widget/scan_frame.dart';

class PatrolScreen extends StatelessWidget {
  final PatrolScreenBloc bloc;
  const PatrolScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create({required Member member}) {
    return Provider<PatrolScreenBloc>(
      create: (context) => PatrolScreenBloc(member: member),
      child: Consumer<PatrolScreenBloc>(
        builder: (context, bloc, _) => PatrolScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: bloc.initialize(),
        builder: (context, fs) {
          return StreamBuilder<PatrolScreenModel>(
              stream: bloc.stream,
              initialData: bloc.model,
              builder: (context, ss) {
                return Scaffold(
                  appBar: AppBar(foregroundColor: Colors.white),
                  extendBody: true,
                  extendBodyBehindAppBar: true,
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => PatrolRecordScreen(
                                donePlaces2Patrol: ss.data!.donePlaces2Patrol!,
                                undonePlaces2Patrol:
                                    ss.data!.undonePlaces2Patrol!,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(6.0),
                            fixedSize:
                                MaterialStateProperty.all(const Size(100, 48)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black87),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: const Text('巡邏紀錄'),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: FloatingActionButton.large(
                            onPressed: () => bloc.toggleTorch().catchError((e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  e.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white),
                                ),
                                behavior: SnackBarBehavior.floating,
                              ));
                            }),
                            backgroundColor: Colors.white,
                            child: Icon(
                              ss.data!.torchOn!
                                  ? Icons.flashlight_off_outlined
                                  : Icons.flashlight_on_outlined,
                              size: 40,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(6.0),
                            fixedSize:
                                MaterialStateProperty.all(const Size(100, 48)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black87),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child: const Text('緊急狀況'),
                        ),
                      ],
                    ),
                  ),
                  body: Stack(
                    alignment: Alignment.center,
                    children: [
                      MobileScanner(
                        allowDuplicates: false,
                        controller: bloc.scannerController,
                        onDetect: (barcode, _) async {
                          bloc.patrol(barcode: barcode).then(
                            (patrolResult) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  patrolResult ? '巡邏成功' : '已巡邏過此巡邏點或QR碼無效',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white),
                                ),
                                behavior: SnackBarBehavior.floating,
                              ));
                            },
                          ).catchError((e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                '發生錯誤',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white),
                              ),
                              behavior: SnackBarBehavior.floating,
                            ));
                          });
                        },
                      ),
                      const Scanframe(),
                    ],
                  ),
                );
              });
        });
  }
}
