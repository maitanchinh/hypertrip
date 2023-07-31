class RequestException implements Exception {
  static const defaultStatusCode = 000;
  final String message;
  final int statusCode;

  RequestException(this.message, {this.statusCode = defaultStatusCode});

  @override
  String toString() {
    return message;
  }
}
