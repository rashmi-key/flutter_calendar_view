import 'package:example/widgets/day_view_widget.dart';
import 'package:example/widgets/week_view_widget.dart';
import 'package:flutter/material.dart';

import '../enumerations.dart';
import '../extension.dart';
import '../widgets/month_view_widget.dart';
import '../widgets/responsive_widget.dart';
import 'create_event_page.dart';
import 'web/web_home_page.dart';

class MonthViewPageDemo extends StatefulWidget {
  const MonthViewPageDemo({
    super.key,
  });

  @override
  _MonthViewPageDemoState createState() => _MonthViewPageDemoState();
}

class _MonthViewPageDemoState extends State<MonthViewPageDemo> {
  String selectedView = "Monthly";

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      webWidget: WebHomePage(
        selectedView: CalendarView.month,
      ),
      mobileWidget: Scaffold(
      /*  floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 8,
          onPressed: () => context.pushRoute(CreateEventPage()),
        ),*/
        body: Column(
          children: [
            if (selectedView == "Monthly")
              SizedBox(
                height: MediaQuery.of(context).size.height / 1,
                child: MonthViewWidget(
                    selectedTimeZone:"UTC",
                    selectedCalendarView:"Monthly",
                  calendarValue: (value) {
                    debugPrint("MonthViewWidget $value");
                    if (mounted) {
                      setState(() {
                        selectedView = value;
                      });
                    }
                  },
                ),
              ),
            if (selectedView == "Day")
              SizedBox(height: 800, child: DayViewWidget(
                selectedTimeZone:"UTC",
                selectedCalendarView:"Day",
                calendarValue: (value) {
                  debugPrint("MonthViewWidget $value");
                  if (mounted) {
                    setState(() {
                      selectedView = value;
                    });
                  }
                },
              )),
            if (selectedView == "Weekly")
              SizedBox(height: 800, child: WeekViewWidget(
                selectedTimeZone:"UTC",
                selectedCalendarView:"Weekly",
                calendarValue: (value) {
                  debugPrint("MonthViewWidget $value");
                  if (mounted) {
                    setState(() {
                      selectedView = value;
                    });
                  }
                },
              ))
          ],
        ),
      ),
    );
  }
}
