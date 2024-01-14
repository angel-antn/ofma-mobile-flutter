String convertTo12HourFormat(String time24) {
  List<String> parts = time24.split(':');
  int hour = int.parse(parts[0]);

  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  hour = hour != 0 ? hour : 12;

  return '${hour.toString().padLeft(2, '0')}:${parts[1]} $period';
}
