import 'package:timeago/timeago.dart' as timeago;

/// Utility class makes date time handling easier in issue_tracker feature
class TimeUtil {
  /// Format utc [time] string to ago format
  /// eg: 2 hours, 3 days etc.
  static String getTimeInAgoFormat(String? time) {
    if (time == null) return '';
    final createdOn = DateTime.parse(time);
    final formattedTime = timeago
        .format(createdOn)
        .replaceAll('a day', '1 day')
        .replaceAll(' ago', '');
    return formattedTime;
  }
}
