
import 'package:date_format/date_format.dart';

/// 格式化为 2022-07-21 12:11:00:555
String formatDateAndTimeByMillis(int time, {String? splitDate, String? splitTime}) {
  return formatDateAndTime(DateTime.fromMillisecondsSinceEpoch(time), splitDate: splitDate, splitTime: splitTime);
}

/// 格式化为 2022-07-21 12:11:00:555
String formatDateAndTime(DateTime dateTime, {String? splitDate, String? splitTime}) {
  return formatDate(dateTime, [yyyy,splitDate??'-',mm,splitDate??'-',dd,' ',HH,splitTime??':',nn,splitTime??':',ss, splitTime??':', SSS]);
}

/// 格式化为 2022-07-21 12:11
String formatToYToM(DateTime dateTime, {String? splitDate, String? splitTime}) {
  return formatDate(dateTime, [yyyy,splitDate??'-',mm,splitDate??'-',dd,' ',HH,splitTime??':',nn]);
}

/// 格式化为 2022-07-21
String formatOnlyDateByMillis(int time, {String? split}) {
  return formatOnlyDate(DateTime.fromMillisecondsSinceEpoch(time), split: split);
}

/// 格式化为 2022-07-21
String formatOnlyDate(DateTime dateTime, {String? split}) {
  return formatDate(dateTime, [yyyy,split??'-',mm,split??'-',dd]);
}

/// 格式化为 12:11:00
String formatOnlyTimeByMillis(int time, {String? split}) {
  return formatOnlyTime(DateTime.fromMillisecondsSinceEpoch(time), split: split);
}

/// 格式化为 12:11:00
String formatOnlyTime(DateTime dateTime, {String? split}) {
  return formatDate(dateTime, [HH,split??':',nn,split??':',ss]);
}

/// 将ISO格式的日期“2022-08-03T10:00:00.000” 格式化为 10:00
String? formatIsoHourMinute(String? date, {String? split}) {
  if(date == null) {
    return date;
  }
  var time = DateTime.tryParse(date);
  if(time != null) {
    return formatDate(time, [HH,split??':',nn]);
  }
  return date;
}

/// 将ISO格式的日期“2022-08-03T10:00:00.000” 格式化为 2022-07-21 12:11
String? formatIsoToYMDHM(String? date, {String? split}) {
  if(date == null) {
    return date;
  }
  var time = DateTime.tryParse(date);
  if(time != null) {
    return formatDate(time, [yyyy,split??'-',mm,split??'-',dd,' ',HH,split??':',nn]);
  }
  return date;
}

/// 格式化为 yymmdd 220803
String formatYYMMDD(DateTime dateTime, {String? split}) {
  return formatDate(dateTime, [yy, mm, dd]);
}

/// 接受ISO格式时间“2022-08-03T10:00:00.000”，用当前时间减去接受时间，得出时间差（分钟）
String? timeDifference(String? date) {
  if(date == null) {
    return date;
  }
  DateTime now = DateTime.now();
  DateTime time = DateTime.parse(date);
  Duration difference = now.difference(time);
  return difference.inMinutes.toString();
}
