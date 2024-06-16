import 'package:intl/intl.dart';

class DateUtil {
  static String convertDate(DateTime date, String format) {
    DateTime dateLoc = date.toLocal();
    //final DateFormat formatter = DateFormat('dd MMM HH:mm');
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateLoc);
  }

}
