import 'package:intl/intl.dart';

String timeFormatter(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat("dd-MMM-yy HH:mm a").format(dateTime);
}
