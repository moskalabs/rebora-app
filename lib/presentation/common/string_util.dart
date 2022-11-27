import 'package:intl/intl.dart';

class StringUtil {
  String numberFormat(int number) {
    var format = NumberFormat('###,###,###,###');
    return format.format(number);
  }
}