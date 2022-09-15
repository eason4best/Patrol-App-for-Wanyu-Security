class APIException implements Exception {
  final String code;
  final String message;
  final String? debugMessage;
  APIException({
    required this.code,
    required this.message,
    this.debugMessage,
  });

  @override
  String toString() =>
      'APIException(Code: $code, Message: $message, Debug Message: $debugMessage)';
}
