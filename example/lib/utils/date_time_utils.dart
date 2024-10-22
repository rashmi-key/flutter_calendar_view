class DateTimeUtils {

  DateTime getCalendarMinDateTime() {
    DateTime now = DateTime.now();
    // Add 12 months (1 year) to the current date
    DateTime minDateTime =
        DateTime(now.year - 2, now.month, now.day, now.hour, now.minute);
    return minDateTime;
  }

  DateTime getCalendarMaxDateTime() {
    DateTime now = DateTime.now();
    // Add 12 months (1 year) to the current date
    DateTime maxDateTime =
        DateTime(now.year + 2, now.month, now.day, now.hour, now.minute);
    return maxDateTime;
  }
}
