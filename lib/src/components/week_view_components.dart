// Copyright (c) 2021 Simform Solutions. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../style/header_style.dart';
import '../typedefs.dart';
import 'common_components.dart';

class WeekPageHeader extends CalendarPageHeader {
  /// A header widget to display on week view.
   WeekPageHeader(
      {Key? key,
      VoidCallback? onNextDay,
      AsyncCallback? onTitleTapped,
      VoidCallback? onPreviousDay,
      required DateTime startDate,
      required DateTime endDate,
      Color iconColor = Constants.black,
      Color backgroundColor = Constants.transparent,
      StringProvider? headerStringBuilder,
      HeaderStyle headerStyle = const HeaderStyle(),
      required VoidCallback? timeZoneValue,
      required String selectedTimeZone,
      required String selectedCalendarView,
      required Function calendarValue})
      : super(
            key: key,
            date: startDate,
            secondaryDate: endDate,
            onNextDay: onNextDay,
            onPreviousDay: onPreviousDay,
            onTitleTapped: onTitleTapped,
            // ignore_for_file: deprecated_member_use_from_same_package
            iconColor: iconColor,
            backgroundColor: backgroundColor,
            dateStringBuilder:
                headerStringBuilder ?? WeekPageHeader._weekStringBuilder,
            headerStyle: headerStyle,
            timeZoneValue: timeZoneValue,
            selectedTimeZone: selectedTimeZone,
            selectedCalendarView: selectedCalendarView,
            calendarValue: calendarValue);

  static String _weekStringBuilder(DateTime date, {DateTime? secondaryDate}) {
   // DateTime now = DateTime.now();

    // Define the format you want (e.g., "MMM yyyy" for Oct 2024)
    DateFormat formatter = DateFormat('dd MMM yyyy');

    // Format the date
    return formatter.format(date);

    /*  "${date.day} / ${date.month} / ${date.year} to "
      "${secondaryDate != null ? "${secondaryDate.day} / "
          "${secondaryDate.month} / ${secondaryDate.year}" : ""}";*/
  }

}

class FullDayHeaderTextConfig {
  /// Set full day events header text config
  const FullDayHeaderTextConfig({
    this.textAlign = TextAlign.center,
    this.maxLines = 2,
    this.textOverflow = TextOverflow.ellipsis,
  });

  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow textOverflow;
}
