import 'package:intl/intl.dart';

class Functions {
  static String formatDateMonth(DateTime date) {
    // Format DateTime to display month name and day (e.g., Jan 15)
    final formatter = DateFormat('MMM');
    return formatter.format(date);
  }

  static String formatDateDay(DateTime date) {
    // Format DateTime to display month name and day (e.g., Jan 15)
    final formatter = DateFormat('d');
    return formatter.format(date);
  }
}
