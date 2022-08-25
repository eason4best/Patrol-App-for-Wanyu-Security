import 'dart:io';

class Utils {
  static String dateString(DateTime dateTime) {
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    final weekday = dateTime.weekday;
    const weekdayInCH = ['ㄧ', '二', '三', '四', '五', '六', '日'];
    return '$year年$month月$day日 星期${weekdayInCH[weekday - 1]}';
  }

  static String timeString(DateTime dateTime) {
    final hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour;
    final minute =
        dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute;
    return '$hour:$minute';
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      return false;
    } on SocketException catch (_) {
      return false;
    }
  }
}
