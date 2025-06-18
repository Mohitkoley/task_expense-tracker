class DateUtil {
  /// Returns the starting date of the week for the given date.
  ///
  /// The week starts on Monday and ends on Sunday.
  ///
  /// Example:
  /// For a date of 2023-08-15, the starting date of the week would be 2023-08-14.
  ///
  /// Parameters:
  /// - `date`: The date for which to find the starting date of the week.
  ///
  /// Returns:
  /// A `DateTime` object representing the starting date of the week.
  static DateTime getStarttingOfWeekByCurrentDate(DateTime date) =>
      date.subtract(Duration(days: date.weekday - 1));
}
