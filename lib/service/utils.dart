import 'dart:io';

class Utils {
  static String currentDateString() {
    final currentDate = DateTime.now();
    final year = currentDate.year;
    final month = currentDate.month;
    final day = currentDate.day;
    final weekday = currentDate.weekday;
    const weekdayInCH = ['ㄧ', '二', '三', '四', '五', '六', '日'];
    return '$year年$month月$day日 星期${weekdayInCH[weekday - 1]}';
  }

  static String currentTimeString() {
    final currentDate = DateTime.now();
    final hour =
        currentDate.hour < 10 ? '0${currentDate.hour}' : currentDate.hour;
    final minute =
        currentDate.minute < 10 ? '0${currentDate.minute}' : currentDate.minute;
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
