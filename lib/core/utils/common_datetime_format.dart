import 'package:intl/intl.dart';

class CommonDatetimeFormat {
  //22 Jan, 2022, 12:00PM
  static DateFormat formattedDate = DateFormat('dd MMM yyyy, hh:mma');

  //7 Jan, 2022
  static DateFormat formattedDateWithoutTime = DateFormat('dd MMM, yyyy');

  //22 Jan
  static DateFormat formattedDateMonth = DateFormat('dd MMM');

  //22 jan 08:16 pm
  static DateFormat formattedDateMonthTime = DateFormat('dd MMM hh:mm a');

  //22
  static DateFormat dateOnly = DateFormat('dd');

  //Aug
  static DateFormat monthOnly = DateFormat('MMM');

  //March
  static DateFormat fullMonth = DateFormat("MMMM");

  //weekday
  static DateFormat weekdayName = DateFormat('EEEE');

  //3 H
  static DateFormat formattedTime = DateFormat('hh:mm a');

  //January 2024
  static DateFormat formattedMonthYear = DateFormat('MMMM yyyy');

  //2025-02-12
  static DateFormat formattedDateOnly = DateFormat('yyyy-MM-dd');

  //21-07-2022
  static DateFormat formattedDateWithoutTime2 = DateFormat('dd-MM-yyyy');

  //25th July,
  static DateFormat formattedDateWithoutTime3 = DateFormat('dd MMMM, yyyy');

  //Feb 2024
  static DateFormat monthYearOnly = DateFormat('MMMM, yyyy');

  //08:16 pm on 7th March, 2024
  static DateFormat formattedDateWithoutTime4 =
      DateFormat('hh:mm a dd MMM, yyyy');

  //10:00 AM
  static DateFormat formattedTime2 = DateFormat('hh:mm a');

  // static DateForm

  //weekdays
  List<String> weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
}

extension DateTimeExt on DateTime {
  String get text => CommonDatetimeFormat.formattedDate.format(this);
  String get textWithoutTime =>
      CommonDatetimeFormat.formattedDateWithoutTime.format(this);
  String get time => CommonDatetimeFormat.formattedTime.format(this);
  String get monthYear => CommonDatetimeFormat.formattedMonthYear.format(this);
  String get dateWithoutTime =>
      CommonDatetimeFormat.formattedDateWithoutTime2.format(this);
  String get dateTime =>
      CommonDatetimeFormat.formattedDateMonthTime.format(this);
  String get dateWithoutThTime =>
      CommonDatetimeFormat.formattedDateWithoutTime3.format(this);

  String get monthDate => CommonDatetimeFormat.formattedDateMonth.format(this);

  String get dateOnly => CommonDatetimeFormat.dateOnly.format(this);

  String get monthOnly => CommonDatetimeFormat.monthOnly.format(this);

  String get fullMonth => CommonDatetimeFormat.fullMonth.format(this);

  String get monthYearOnly => CommonDatetimeFormat.monthYearOnly.format(this);

  String get dateWithoutTime4 =>
      CommonDatetimeFormat.formattedDateWithoutTime4.format(this);

  String get time2 => CommonDatetimeFormat.formattedTime2.format(this);

  String get dateOnly2 => CommonDatetimeFormat.formattedDateOnly.format(this);

  String get weekdayName => CommonDatetimeFormat.weekdayName.format(this);

  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);
    if (difference < const Duration(minutes: 1)) {
      return 'Just now';
    } else if (difference < const Duration(hours: 1)) {
      return '${difference.inMinutes}min';
    } else if (difference < const Duration(days: 1)) {
      return '${difference.inHours}h';
    } else if (difference < const Duration(days: 7)) {
      return textWithoutTime;
    } else {
      return text;
    }
  }
}
