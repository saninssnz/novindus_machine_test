import 'package:intl/intl.dart';

class Utils{
  static String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    DateFormat formatter = DateFormat('MMMM d, yyyy');
    String formatted = formatter.format(date);
    return formatted;
  }

  static String formatTime(String timeStr) {
    DateFormat formatter = DateFormat('HH:mm');
    DateTime time = DateFormat('HH:mm:ss').parse(timeStr);
    String formatted = formatter.format(time);
    return formatted;
  }

  static String isAm(String timeStr) {
    String dt = "";
    DateTime time = DateFormat('hh:mm').parse(timeStr);
    if( time.hour < 12){
      dt = "AM";
    }
    else{
      dt = "PM";
    }
    return dt;
  }
}