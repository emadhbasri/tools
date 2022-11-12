import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
export 'package:shamsi_date/shamsi_date.dart';
String toolsmakeDurationToString(DateTime date) {
  if (date.isAfter(DateTime.now())) {
    return '';
  }
  DateTimeRange range = DateTimeRange(start: date, end: DateTime.now());
  Duration duration = range.duration;
  if (duration.inDays > 365) {
    return '${duration.inDays ~/ 365}y';
  } else if (duration.inDays > 30) {
    return '${duration.inDays ~/ 30}mon';
  } else if (duration.inDays > 0) {
    return '${duration.inDays}d';
  } else if (duration.inHours > 0) {
    return '${duration.inHours}h';
  } else if (duration.inMinutes > 0) {
    return '${duration.inMinutes}min';
  } else if (duration.inSeconds > 0) {
    return '${duration.inSeconds}s';
  } else {
    return '';
  }
}

String toolsintToWeekDayJalali(int index) {
  switch (index) {
    case 1:
      return 'شنبه';
    case 2:
      return 'یک شنبه';
    case 3:
      return 'دو شنبه';
    case 4:
      return 'سه شنبه';
    case 5:
      return 'چهار شنبه';
    case 6:
      return 'پنج شنبه';
    case 7:
      return 'جمعه';
    default:
      return '';
  }
}

String toolsintToMonthJalali(int index) {
  switch (index) {
    case 1:
      return 'فروردین';
    case 2:
      return 'اردیبهشت';
    case 3:
      return 'خرداد';
    case 4:
      return 'تیر';
    case 5:
      return 'مرداد';
    case 6:
      return 'شهریور';
    case 7:
      return 'مهر';
    case 8:
      return 'آبان';
    case 9:
      return 'آذر';
    case 10:
      return 'دی';
    case 11:
      return 'بهمن';
    case 12:
      return 'اسفند';
    default:
      return '';
  }
}

String toolsintToMonthMilady(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'dec';
    default:
      return '';
  }
}

class YMDW {
  final String year, month, day;
  final String? weak;
  YMDW(this.year, this.month, this.day, [this.weak]);
}

String toolsmakeDate({
  dynamic date,
  bool dateIsJalali = false,
  String char = '/',
  String space = ' ',
  required bool isJalali,
  bool isWeekDay = false,
  bool isWeekDayLeft = false,
}) {
  DateTime outDate;
  if (date == null) return '';

  if (date is String) {
    List<int> dates = date.split(char).map((e) => int.parse(e)).toList();
    if (dateIsJalali) {
      outDate = Jalali(dates[0], dates[1], dates[2]).toDateTime();
    } else {
      DateTime? temp = DateTime.tryParse(date);
      if (temp == null) {
        outDate = DateTime(dates[0], dates[1], dates[2]);
      } else {
        outDate = temp;
      }
    }
  } else if(date is Jalali){
    outDate=date.toDateTime();
  }else{
    outDate = date;
  }
  YMDW out;
  if (isJalali) {
    Jalali jal = Jalali.fromDateTime(outDate);
    out = YMDW(
        jal.year.toString().padLeft(4, '0'),
        jal.month.toString().padLeft(2, '0'),
        jal.day.toString().padLeft(2, '0'),
        toolsintToWeekDayJalali(jal.weekDay));
  } else {
    out = YMDW(
        outDate.year.toString().padLeft(4, '0'),
        outDate.month.toString().padLeft(2, '0'),
        outDate.day.toString().padLeft(2, '0'));
  }

  if (isWeekDay) {
    if (isWeekDayLeft) {
      return '${out.weak}$space${out.year}$char${out.month}$char${out.day}';
    } else {
      return '${out.year}$char${out.month}$char${out.day}$space${out.weak}';
    }
  } else {
    return '${out.year}$char${out.month}$char${out.day}';
  }
}
