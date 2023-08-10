import 'package:cloud_firestore/cloud_firestore.dart';

String toTime(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime dateTime2 = DateTime.parse(Timestamp.now().toDate().toString());

  int days = dateTime2.difference(dateTime).inDays;
  int hours = dateTime2.difference(dateTime).inHours;
  int minute = dateTime2.difference(dateTime).inMinutes;
  int second = dateTime2.difference(dateTime).inSeconds;

  if (days > 0) {
    return '${days}d';
  } else if (hours > 0) {
    return '${hours}h';
  } else if (minute > 0) {
    return '${minute}m';
  } else {
    return '${second}s';
  }
}
