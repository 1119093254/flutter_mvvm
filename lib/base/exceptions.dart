
class ServerError implements Exception {
  String? message;
  int? errorCode;
  ServerError(this.message, {this.errorCode}):super();
}

class UnSupportVersionError implements Exception {
  String? message;
  int? errorCode;
  UnSupportVersionError(this.message, {this.errorCode}):super();
}