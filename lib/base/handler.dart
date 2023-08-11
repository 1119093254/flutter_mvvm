
import 'package:dio/dio.dart';

class DioErrorHandler {

  static handleError(DioError e, {ErrorDispatcher? allDispatcher,
    ErrorDispatcher? timeoutDispatcher, ErrorDispatcher? cancelDispatcher,
    ErrorDispatcher? responseDispatcher, ErrorDispatcher? otherDispatcher}) {
    switch(e.type) {
      case DioException.connectionTimeout:
      case DioException.receiveTimeout:
      case DioException.sendTimeout:
        if (timeoutDispatcher?.call(e) != true) {
          allDispatcher?.call(e);
        }
        break;
      case DioException.requestCancelled:
        if (cancelDispatcher?.call(e) != true) {
          allDispatcher?.call(e);
        }
        break;
      default:break;
    }
  }
}

typedef ErrorDispatcher = bool Function(DioError);