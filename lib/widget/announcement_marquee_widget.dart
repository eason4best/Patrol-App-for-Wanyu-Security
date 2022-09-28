import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:security_wanyu/bloc/home_screen_bloc.dart';

class AnnouncementMarqueeWidget extends StatelessWidget {
  final HomeScreenBloc bloc;
  const AnnouncementMarqueeWidget({Key? key, required this.bloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<String>(
          future: bloc.getMarqueeContent(),
          builder: (context, snapshot) => snapshot.hasData
              ? Marquee(
                  text: snapshot.data!,
                  pauseAfterRound: const Duration(seconds: 2),
                  blankSpace: 100,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Theme.of(context).primaryColor),
                )
              : Container(),
        ),
      ),
    );
  }
}
