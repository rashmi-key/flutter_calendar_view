// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../calendar_event_data.dart';
import '../constants.dart';
import '../extensions.dart';
import '../style/header_style.dart';
import '../typedefs.dart';
import '../enumerations.dart';
import 'components.dart';

class CalendarPageHeader extends StatefulWidget {
  /// When user taps on right arrow.
  final VoidCallback? onNextDay;

  ///When user taps on timezone
  final VoidCallback? timeZoneValue;
  final String selectedTimeZone;

  String? selectedCalendarView;

  // final VoidCallback? calendarValue;
  Function calendarValue;

  /// When user taps on left arrow.
  final VoidCallback? onPreviousDay;

  /// When user taps on title.
  final AsyncCallback? onTitleTapped;

  /// Date of month/day.
  final DateTime date;

  /// Secondary date. This date will be used when we need to define a
  /// range of dates.
  /// [date] can be starting date and [secondaryDate] can be end date.
  final DateTime? secondaryDate;

  /// Provides string to display as title.
  final StringProvider dateStringBuilder;

  // TODO: Need to remove after next release
  /// background color of header.
  @Deprecated("Use Header Style to provide background")
  final Color backgroundColor;

  // TODO: Need to remove after next release
  /// Color of icons at both sides of header.
  @Deprecated("Use Header Style to provide icon color")
  final Color iconColor;

  /// Style for Calendar's header
  final HeaderStyle headerStyle;

  /// Common header for month and day view In this header user can define format
  /// in which date will be displayed by providing [dateStringBuilder] function.
  CalendarPageHeader({
    Key? key,
    required this.date,
    required this.dateStringBuilder,
    this.onNextDay,
    required this.selectedTimeZone,
    required this.selectedCalendarView,
    required this.calendarValue,
    this.timeZoneValue,
    this.onTitleTapped,
    this.onPreviousDay,
    this.secondaryDate,
    @Deprecated("Use Header Style to provide background")
    this.backgroundColor = Constants.transparent,
    @Deprecated("Use Header Style to provide icon color")
    this.iconColor = Constants.black,
    this.headerStyle = const HeaderStyle(),
  }) : super(key: key);

  @override
  State<CalendarPageHeader> createState() => _CalendarPageHeaderState();
}

class _CalendarPageHeaderState extends State<CalendarPageHeader> {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.headerStyle.headerMargin,
      padding: widget.headerStyle.headerPadding,
      decoration:
          // ignore_for_file: deprecated_member_use_from_same_package
          widget.headerStyle.decoration ??
              BoxDecoration(color: widget.backgroundColor),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.headerStyle.leftIconVisible)
            IconButton(
              onPressed: widget.onPreviousDay,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: widget.headerStyle.leftIconPadding,
              icon: widget.headerStyle.leftIcon ??
                  Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: Color(0xFF808080),
                  ),
            ),
          InkWell(
            onTap: null, //widget.onTitleTapped,
            child: Text(
                widget.dateStringBuilder(widget.date,
                    secondaryDate: widget.secondaryDate),
                textAlign: widget.headerStyle.titleAlign,
                style: TextStyle(
                    color: Color(
                      0xFF252525,
                    ),
                    fontWeight:
                        FontWeight.w300) //widget.headerStyle.headerTextStyle,
                ),
          ),
          if (widget.headerStyle.rightIconVisible)
            IconButton(
              onPressed: widget.onNextDay,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: widget.headerStyle.rightIconPadding,
              icon: widget.headerStyle.rightIcon ??
                  Icon(
                    Icons.chevron_right,
                    size: 30,
                    color: Color(0xFF808080),
                  ),
            ),
          TextButton.icon(
            label: Text(
              widget.selectedTimeZone,
              style: TextStyle(color: Color(0xFF808080)),
            ),
            onPressed: widget.timeZoneValue,
            iconAlignment: IconAlignment.end,
            icon: widget.headerStyle.rightIcon ??
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: Color(0xFF808080),
                ),
          ),
          TextButton.icon(
              key: _menuKey,
              label: Text(
                widget.selectedCalendarView ?? "",
                style: TextStyle(color: Color(0xFF808080)),
              ),
              onPressed: (() {
                final RenderBox renderBox =
                    _menuKey.currentContext!.findRenderObject() as RenderBox;
                final offset = renderBox.localToGlobal(Offset.zero);

                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(
                    offset.dx,
                    offset.dy + renderBox.size.height,
                    offset.dx + renderBox.size.width,
                    offset.dy + renderBox.size.height,
                  ),
                  items: [
                    if (widget.selectedCalendarView != "Day")
                      PopupMenuItem<String>(
                        value: "Day",
                        child: Text("Day"),
                        onTap: (() {
                          widget.selectedCalendarView = "Day";
                          widget.selectedCalendarView = "Day";
                          widget.calendarValue("Day");
                          setState(() {});
                        }),
                      ),
                    if (widget.selectedCalendarView != "Weekly")
                      PopupMenuItem<String>(
                        value: "Weekly",
                        child: Text("Weekly"),
                        onTap: (() {
                          widget.selectedCalendarView = "Weekly";
                          widget.selectedCalendarView = "Weekly";
                          widget.calendarValue("Weekly");
                          setState(() {});
                        }),
                      ),
                    if (widget.selectedCalendarView != "Monthly")
                      PopupMenuItem<String>(
                        value: "Monthly",
                        child: Text("Monthly"),
                        onTap: (() {
                          widget.selectedCalendarView = "Monthly";
                          widget.selectedCalendarView = "Monthly";
                          widget.calendarValue("Monthly");
                          setState(() {});
                        }),
                      ),
                  ],
                );
              }),
              //calendarValue,
              iconAlignment: IconAlignment.end,
              icon: widget.headerStyle.rightIcon ??
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: Color(0xFF808080),
                  )),
        ],
      ),
    );
  }
}

/// This will be used in day and week view
class DefaultPressDetector extends StatelessWidget {
  /// default press detector builder used in week and day view
  const DefaultPressDetector({
    required this.date,
    required this.height,
    required this.width,
    required this.heightPerMinute,
    required this.minuteSlotSize,
    this.onDateTap,
    this.onDateLongPress,
    this.startHour = 0,
  });

  final DateTime date;
  final double height;
  final double width;
  final double heightPerMinute;
  final MinuteSlotSize minuteSlotSize;
  final DateTapCallback? onDateTap;
  final DatePressCallback? onDateLongPress;
  final int startHour;

  @override
  Widget build(BuildContext context) {
    final heightPerSlot = minuteSlotSize.minutes * heightPerMinute;
    final slots = (Constants.hoursADay * 60) ~/ minuteSlotSize.minutes;

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          for (int i = 0; i < slots; i++)
            Positioned(
              top: heightPerSlot * i,
              left: 0,
              right: 0,
              bottom: height - (heightPerSlot * (i + 1)),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onLongPress: () => onDateLongPress?.call(
                  getSlotDateTime(i),
                ),
                onTap: () => onDateTap?.call(
                  getSlotDateTime(i),
                ),
                child: SizedBox(
                  width: width,
                  height: heightPerSlot,
                ),
              ),
            ),
        ],
      ),
    );
  }

  DateTime getSlotDateTime(int slot) => DateTime(
        date.year,
        date.month,
        date.day,
        0,
        (minuteSlotSize.minutes * slot) + (startHour * 60),
      );
}

/// This will be used in day and week view
class DefaultEventTile<T> extends StatelessWidget {
  const DefaultEventTile({
    required this.date,
    required this.events,
    required this.boundary,
    required this.startDuration,
    required this.endDuration,
  });

  final DateTime date;
  final List<CalendarEventData<T>> events;
  final Rect boundary;
  final DateTime startDuration;
  final DateTime endDuration;

  @override
  Widget build(BuildContext context) {
    if (events.isNotEmpty) {
      final event = events[0];
      return RoundedEventTile(
        borderRadius: BorderRadius.circular(10.0),
        title: event.title,
        totalEvents: events.length - 1,
        description: event.description,
        padding: EdgeInsets.all(10.0),
        backgroundColor: event.color,
        margin: EdgeInsets.all(2.0),
        titleStyle: event.titleStyle,
        descriptionStyle: event.descriptionStyle,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
