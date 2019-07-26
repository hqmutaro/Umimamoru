enum Level {
  Calm,
  Ordinarily,
  Fast
}

// 非同期処理で毎回データをとって、波の速さをここにぶちこんで
// それに応じて処理する]
// ignore: missing_return
Level getLevel(double waveSpeed) {
  if (waveSpeed <= 0.5) {
    return Level.Calm;
  }
  if (waveSpeed <= 1.5) {
    return Level.Ordinarily;
  }
  if (waveSpeed >= 1.6) {
    return Level.Fast;
  }
}