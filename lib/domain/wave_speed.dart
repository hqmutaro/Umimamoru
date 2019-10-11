enum Level {
  Calm,
  Ordinarily,
  Fast,
  None
}

Level getLevel(double speed) {
  if (speed <= 0.3) {
    return Level.Calm;
  }
  if (speed < 1.6) {
    return Level.Ordinarily;
  }
  if (speed >= 1.6) {
    return Level.Fast;
  }
  return Level.None;
}

String getLevelToString(Level level) {
  return level.toString().replaceFirst(level.toString().split('.')[0] + "." , "" );
}