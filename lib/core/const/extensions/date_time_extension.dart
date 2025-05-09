extension DateTimeExtension on String {
  String get formattedDateTime {
    try {
      final date = DateTime.parse(this);
      return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
    } catch (e) {
      return this;
    }
  }
}
