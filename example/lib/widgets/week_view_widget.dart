import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../pages/event_details_page.dart';

class WeekViewWidget extends StatefulWidget {
  final GlobalKey<WeekViewState>? state;
  final double? width;
  Function? calendarValue;
  String? selectedCalendarView;
  String? selectedTimeZone;

   WeekViewWidget({super.key, this.state, this.width,this.calendarValue, this.selectedTimeZone , this.selectedCalendarView });

  @override
  State<WeekViewWidget> createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends State<WeekViewWidget> {
  @override
  Widget build(BuildContext context) {
    return WeekView(
      key: widget.state,
      width: widget.width,
      showLiveTimeLineInAllDays: true,
      timeLineWidth: 65,
      liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
        color: Colors.redAccent,
        showTime: true,
      ),
      onEventTap: (events, date) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              event: events.first,
            ),
          ),
        );
      },
      onEventLongTap: (events, date) {
        SnackBar snackBar = SnackBar(content: Text("on LongTap"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      timeZoneValue:()
      {

      },
      calendarValue: (value) {
        widget.calendarValue!(value);
      },

      selectedTimeZone: widget.selectedTimeZone??"", selectedCalendarView: widget.selectedCalendarView??"",
    );
  }
}
