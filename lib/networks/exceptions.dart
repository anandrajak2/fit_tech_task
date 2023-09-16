class NetworkExceptionModule implements Exception {
  final String? code, message;
  NetworkExceptionModule({required this.message, this.code});
}
