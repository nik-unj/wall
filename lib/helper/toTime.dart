import 'package:cloud_firestore/cloud_firestore.dart';

String toDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String year = dateTime.year.toString();

  String month = dateTime.month.toString();

  String date = dateTime.day.toString();

  String hour = dateTime.hour.toString();

  String minute = dateTime.minute.toString();

  String formattedString = '$hour:$minute • $date/$month/$year';

  return formattedString;
}
