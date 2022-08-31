import 'dart:io';

class Utils {
  static String datetimeString(
    DateTime dateTime, {
    onlyDate = false,
    onlyTime = false,
    showWeekday = false,
    isMinguo = false,
  }) {
    if (onlyDate && onlyTime) {
      throw ArgumentError(
          onlyDate, '[onlyDate] and [onlyTime] cannot both be true.');
    }
    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    final weekday = dateTime.weekday;
    const weekdayInCH = ['ㄧ', '二', '三', '四', '五', '六', '日'];
    final hour = dateTime.hour < 10 ? '0${dateTime.hour}' : dateTime.hour;
    final minute =
        dateTime.minute < 10 ? '0${dateTime.minute}' : dateTime.minute;
    if (!onlyDate && !onlyTime) {
      if (showWeekday) {
        return isMinguo
            ? '民國${year - 1911}年$month月$day日 星期${weekdayInCH[weekday - 1]} $hour:$minute'
            : '$year年$month月$day日 星期${weekdayInCH[weekday - 1]} $hour:$minute';
      } else {
        return isMinguo
            ? '民國${year - 1911}年$month月$day日 $hour:$minute'
            : '$year年$month月$day日 $hour:$minute';
      }
    } else if (onlyDate) {
      if (showWeekday) {
        return isMinguo
            ? '民國${year - 1911}年$month月$day日 星期${weekdayInCH[weekday - 1]}'
            : '$year年$month月$day日 星期${weekdayInCH[weekday - 1]}';
      } else {
        return isMinguo
            ? '民國${year - 1911}年$month月$day日'
            : '$year年$month月$day日';
      }
    } else {
      return '$hour:$minute';
    }
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
