import 'package:flutter/material.dart';
import 'package:security_wanyu/bloc/shift_screen_bloc.dart';
import 'package:security_wanyu/model/place2patrol.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShiftCalendarWidget extends StatefulWidget {
  final ShiftScreenBloc bloc;
  final DateTime selectedDate;
  final List<Place2Patrol> places2Patrol;
  const ShiftCalendarWidget({
    Key? key,
    required this.bloc,
    required this.selectedDate,
    required this.places2Patrol,
  }) : super(key: key);

  @override
  State<ShiftCalendarWidget> createState() => _ShiftCalendarWidgetState();
}

class _ShiftCalendarWidgetState extends State<ShiftCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 24,
      ),
      elevation: 4.0,
      color: const Color(0xfffafafa),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SfCalendar(
          controller: widget.bloc.calendarController,
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
          headerHeight: 0,
          viewNavigationMode: ViewNavigationMode.none,
          onSelectionChanged: widget.bloc.onSelectDate,
          monthCellBuilder: (context, details) => Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: widget.selectedDate.day == details.date.day &&
                      widget.selectedDate.month == details.date.month
                  ? Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    )
                  : null,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: Text(
                    details.date.day.toString(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: widget.selectedDate.month == details.date.month
                              ? Colors.black87
                              : Colors.black38,
                          height: 1,
                        ),
                  ),
                ),
                widget.places2Patrol.any((pp) => pp.day == details.date.day) &&
                        widget.selectedDate.month == details.date.month
                    ? Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
      ),
    );
  }
}
