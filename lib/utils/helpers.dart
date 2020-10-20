class Helper {
  static String convertHoursMinutes(int minutes) {
    Duration d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0]}h ${parts[1]}m';
  }
}