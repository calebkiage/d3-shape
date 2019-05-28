class DrawException implements Exception {
  final message;

  DrawException([this.message]);

  String toString() {
    if (message == null) return "DrawException";
    return "DrawException: $message";
  }
}