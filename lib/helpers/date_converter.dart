class DateConverter {
  static String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final DateTime dateTime = DateTime.parse(date);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }
}
