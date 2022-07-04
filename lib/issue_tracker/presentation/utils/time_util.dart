import 'package:timeago/timeago.dart' as timeago;

class TimeUtil {
  /// Format utc [time] string to ago format
  /// eg: 2 hours, 3 days etc.
  static String getTimeInAgoFormat(String? time) {
    if (time == null) return '';
    final createdOn = DateTime.parse(time);
    return timeago.format(createdOn).replaceAll(' ago', '');
  }
}
