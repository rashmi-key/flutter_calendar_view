import 'package:calendar_view/calendar_view.dart';
import 'package:example/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

import '../pages/event_details_page.dart';

class MonthViewWidget extends StatefulWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;
   Function? calendarValue;
   String? selectedTimeZone;
   String? selectedCalendarView;

   MonthViewWidget({
    super.key,
    this.state,
    this.width,
     this.calendarValue,
     this.selectedTimeZone,
     this.selectedCalendarView
  });

  @override
  State<MonthViewWidget> createState() => _MonthViewWidgetState();

  static String dateString(DateTime date, {DateTime? secondaryDate}) =>
      "${date.month} - ${date.year}";
}

class _MonthViewWidgetState extends State<MonthViewWidget> {
  String? _selectedOption = "Day";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          height: MediaQuery.of(context).size.height/1,
          child: MonthView(
           // minMonth: DateTimeUtils().getCalendarMinDateTime(),
          //  maxMonth: DateTimeUtils().getCalendarMaxDateTime(),
            // dateStringBuilder: dateString()
            headerStyle: HeaderStyle(
                decoration: BoxDecoration(color: Colors.transparent)),
            //headerBuilder: MonthHeader.hidden, // To hide month header
            key: widget.state,
            width: widget.width,
            hideDaysNotInMonth: false,
            onEventTap: (event, date) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailsPage(
                    event: event,
                  ),
                ),
              );
            },
            onEventLongTap: (event, date) {
              SnackBar snackBar = SnackBar(content: Text("on LongTap"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            selectedTimeZone: widget.selectedTimeZone!,
            selectedCalendarView: widget.selectedCalendarView!,
            timeZoneValue: (() {
              debugPrint("timeZoneValue 455");
            }),
            calendarValue: (value) {
              widget.calendarValue!(value);
            },
          ),
        ),
      ],
    );
  }
}
