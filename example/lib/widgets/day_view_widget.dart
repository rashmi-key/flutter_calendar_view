import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../pages/event_details_page.dart';

class DayViewWidget extends StatefulWidget {
  final GlobalKey<DayViewState>? state;
  final double? width;
  Function? calendarValue;
  String? selectedTimeZone;
  String? selectedCalendarView;

  DayViewWidget(
      {super.key,
      this.state,
      this.width,
      this.calendarValue,
      this.selectedTimeZone,
      this.selectedCalendarView});

  @override
  State<DayViewWidget> createState() => _DayViewWidgetState();
}

class _DayViewWidgetState extends State<DayViewWidget> {
  @override
  Widget build(BuildContext context) {
    return DayView(
      key: widget.state,
      width: widget.width,
      startDuration: Duration(hours: 8),
      showHalfHours: true,
      heightPerMinute: 3,
      timeLineBuilder: _timeLineBuilder,
      hourIndicatorSettings: HourIndicatorSettings(
        color: Theme.of(context).dividerColor,
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
      halfHourIndicatorSettings: HourIndicatorSettings(
        color: Theme.of(context).dividerColor,
        lineStyle: LineStyle.dashed,
      ),
      verticalLineOffset: 0,
      timeLineWidth: 65,
      showLiveTimeLineInAllDays: true,
      liveTimeIndicatorSettings: LiveTimeIndicatorSettings(
        color: Colors.redAccent,
        showBullet: false,
        showTime: true,
        showTimeBackgroundView: true,
      ),
      selectedTimeZone: widget.selectedTimeZone??"",
      selectedCalendarView: widget.selectedCalendarView??"",
      calendarValue: (value) {
        widget.calendarValue!(value);
      },
    );
  }

  Widget _timeLineBuilder(DateTime date) {
    if (date.minute != 0) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            top: -8,
            right: 8,
            child: Text(
              "${date.hour}:${date.minute}",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black.withAlpha(50),
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    }

    final hour = ((date.hour - 1) % 12) + 1;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          top: -8,
          right: 8,
          child: Text(
            "$hour ${date.hour ~/ 12 == 0 ? "am" : "pm"}",
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
