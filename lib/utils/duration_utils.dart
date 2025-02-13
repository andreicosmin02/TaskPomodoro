Duration calculateRestDuration(Duration stopwatchDuration) {
  int minutes = stopwatchDuration.inMinutes;
  int restTime = (minutes / 25 * 5).ceil();
  if (restTime < 5) {
    restTime = 5;
  }
  return Duration(minutes: restTime);
}

String formatDuration(Duration duration) {
  return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
}