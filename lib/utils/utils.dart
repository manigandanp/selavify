import 'package:intl/intl.dart';

abstract class Utils {
  static String getCurrentDateAsString({String format}) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String timesampToDate(int timestamp, {format = 'dd-MM-yyyy'}) =>
      DateFormat(format).format(
        DateTime.fromMillisecondsSinceEpoch(timestamp),
      );
}
