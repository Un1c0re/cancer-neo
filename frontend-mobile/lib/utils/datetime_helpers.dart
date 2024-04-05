DateTime getFirstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getFirstDayOfNextMonth(DateTime date) {
  if (date.month == 12) {
    return DateTime(date.year + 1, 1, 1);
  } else {
    return DateTime(date.year, date.month + 1, 1);
  }
}