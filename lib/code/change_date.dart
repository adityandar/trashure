import 'package:intl/intl.dart';

String changeDate(int time) {
  String date = DateFormat("dd-MM-yyyy")
      .format(DateTime.fromMicrosecondsSinceEpoch(time));
  return date;
}

int changeDateToInt(String date) {
  return DateFormat("dd-MM-yyyy").parse(date).toUtc().millisecondsSinceEpoch;
}
