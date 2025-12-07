String formatDate(DateTime date, {bool withDayName = false}) {
  if (!withDayName) {
    String formattedDate =
        '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    return formattedDate;
  }
  final days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];

  String dayName = days[date.weekday % 7];
  String formattedDate =
      '$dayName, ${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  return formattedDate;
}
