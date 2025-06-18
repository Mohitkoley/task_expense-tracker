class DateUtil {
  /// Returns the date 7 days after the given date.
  ///
  /// Example:
  /// For a date of 2023-08-15, the date 7 days after would be 2023-08-22.
  ///
  /// Parameters:
  /// - `date`: The date for which to find the date 7 days after.
  ///
  /// Returns:
  /// A `DateTime` object representing the date 7 days after the given date.
  static DateTime get7daysAfter(DateTime date) =>
      date.add(const Duration(days: 7));
}
