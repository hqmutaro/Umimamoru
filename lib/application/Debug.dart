class Debug {

  static bool _isDebugMode = false;

  static void onDebugMode() => _isDebugMode = true;

  static void unDebugMode() => _isDebugMode = false;

  static bool isDebugMode() => _isDebugMode;
}