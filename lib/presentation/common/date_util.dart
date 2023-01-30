import 'package:intl/intl.dart';

class DateUtil {

  String changeMMDDHHMM(String date) {
    DateFormat dateFormat = DateFormat("MM.dd HH:mm");
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return date;

    return dateFormat.format(dateTime);
  }

  String changeYYYMMDDHHMM(String date) {
    DateFormat dateFormat = DateFormat("yyyy년 MM월 d일 HH:mm");
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

  int _diffDateTime(String date) {
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return 0;

    var toDay = DateTime.now();
    int difference = int.parse(
        dateTime.difference(toDay).inHours.toString());
    return difference;
  }

  DateTime? _parseDateTime(String date) {
    try{
      return DateTime.parse(date);
    } on Exception catch(e) {
      return null;
    }
  }

  String oldDateFormat(String date) {
    var dateTime = _parseDateTime(date);
    if ( dateTime == null ) return "";

    var diffTime = _diffDateTime(date);
    if (diffTime <= 24) {
      if (diffTime <= 0 ) return "방금전";
      return "$diffTime시간 전";
    }

    var diffDay = diffDateDay(date);

    return "$diffDay일 전";
  }

 String nowYear() {
    var toDay = DateTime.now();
    DateFormat dateFormat = DateFormat("yyyy");

    return dateFormat.format(toDay);
  }


  String yearDateFormat(DateTime time) {
    DateFormat dateFormat = DateFormat("yyyy");

    return dateFormat.format(time);
  }

  String nowMonth() {
    var toDay = DateTime.now();
    DateFormat dateFormat = DateFormat("MM");

    return dateFormat.format(toDay);
  }

  String monthDateFormat(DateTime time) {
    DateFormat dateFormat = DateFormat("MM");

    return dateFormat.format(time);
  }
}