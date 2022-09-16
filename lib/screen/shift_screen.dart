import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_wanyu/bloc/shift_screen_bloc.dart';
import 'package:security_wanyu/model/shift_screen_model.dart';
import 'package:security_wanyu/other/utils.dart';
import 'package:security_wanyu/widget/shift_calendar_widget.dart';
import 'package:security_wanyu/widget/shift_customer_widget.dart';

class ShiftScreen extends StatelessWidget {
  final ShiftScreenBloc bloc;
  const ShiftScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  static Widget create() {
    return Provider<ShiftScreenBloc>(
      create: (context) => ShiftScreenBloc(),
      child: Consumer<ShiftScreenBloc>(
        builder: (context, bloc, _) => ShiftScreen(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('班表'),
      ),
      body: FutureBuilder<void>(
          future: bloc.initialize(),
          builder: (context, _) {
            return StreamBuilder<ShiftScreenModel>(
                stream: bloc.stream,
                initialData: bloc.model,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: Text(
                          Utils.datetimeString(snapshot.data!.selectedDate!,
                              onlyDate: true, showWeekday: true),
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(height: 1),
                        ),
                      ),
                      ShiftCustomerWidget(
                        dayShiftCustomers: Set<String>.from(snapshot
                            .data!.places2Patrol!
                            .where((pp) =>
                                pp.day == snapshot.data!.selectedDate!.day)
                            .map((pp) => pp.customerName!)).toList(),
                      ),
                      ShiftCalendarWidget(
                        bloc: bloc,
                        selectedDate: snapshot.data!.selectedDate!,
                        places2Patrol: snapshot.data!.places2Patrol!,
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
