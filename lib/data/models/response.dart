class Response {
  final bool status;
  final String message;
  final String tx;

  const Response({
    required this.status,
    required this.message,
    this.tx = '',
  });
}
