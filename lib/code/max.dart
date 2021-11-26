import 'package:trashure_new/models/weekly.dart';
import 'dart:math';

int findMax(Weekly weekly) {
  List<int> list = List<int>();
  // ignore: unnecessary_statements
  (weekly.satu != null) ? list.add(weekly.satu) : null;
  // ignore: unnecessary_statements
  (weekly.dua != null) ? list.add(weekly.dua) : null;
  // ignore: unnecessary_statements
  (weekly.tiga != null) ? list.add(weekly.tiga) : null;
  // ignore: unnecessary_statements
  (weekly.empat != null) ? list.add(weekly.empat) : null;

  return list.reduce(max);
}
