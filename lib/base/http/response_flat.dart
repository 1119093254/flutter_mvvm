import '../exceptions.dart';
import 'base.dart';

/// 处理成功请求，错误通过ServerError抛出
T? flatResponse<T>(BaseResponse<T> response) {
  if (response.result == 1) {
    return response.data;
  } else {
    throw ServerError(response.msg, errorCode: response.errorCode);
  }
}

/// 处理成功请求，错误通过ServerError抛出
List<T>? flatListResponse<T>(BaseListResponse<T> response) {
  if (response.result == 1) {
    return response.data;
  } else {
    throw ServerError(response.msg, errorCode: response.errorCode);
  }
}
