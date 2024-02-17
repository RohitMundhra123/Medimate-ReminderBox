String formatTime(DateTime dateTime) {
  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

DateTime findNearestTime(List<dynamic> doses) {
  DateTime now = DateTime.now();
  List<DateTime> doseTimes = doses.map((dose) => DateTime.parse(dose)).toList();

  doseTimes.sort((a, b) => a
      .difference(now)
      .inSeconds
      .abs()
      .compareTo(b.difference(now).inSeconds.abs()));

  return doseTimes.first;
}
