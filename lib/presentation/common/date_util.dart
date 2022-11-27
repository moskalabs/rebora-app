import 'package:intl/intl.dart';

class DateUtil {

  String changeMMDDHHMM(String date) {
    DateFormat dateFormat = DateFormat("MM.dd HH:mm");
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return date;

    return dateFormat.format(dateTime);
  }

  String changeMMDD(String date) {
    DateFormat dateFormat = DateFormat("MM월 dd일");
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return date;

    return dateFormat.format(dateTime);
  }

  String changeTime(String date) {
    DateFormat dateFormat = DateFormat("HH:mm");
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return date;

    return dateFormat.format(dateTime);
  }

  int diffDateDay(String date) {
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return 0;

    var toDay = DateTime.now();
    int difference = int.parse(
        dateTime.difference(toDay).inDays.toString());
    return difference;
  }

  int diffDateMinutes(String date) {
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return 0;

    var toDay = DateTime.now();
    int difference = int.parse(
        dateTime.difference(toDay).inMinutes.toString());
    return difference;
  }

  DateTime? _parseDateTime(String date) {
    try{
      return DateTime.parse(date);
    } on Exception catch(e) {
      return null;
    }
  }

  String nowYear() {
    var toDay = DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy");

    return dateFormat.format(toDay);
  }

  String nowMonth() {
    var toDay = DateTime.now();
    DateFormat dateFormat = DateFormat("MM");

    return dateFormat.format(toDay);
  }
}