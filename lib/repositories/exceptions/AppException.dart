class AppException implements Exception {
  final String message;

  AppException(this.message);  // Pass your message in constructor.

  @override
  String toString() {
    return message;
  }
}