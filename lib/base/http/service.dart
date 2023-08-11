
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'service.g.dart';

@RestApi()
abstract class RequestService {
  factory RequestService(Dio dio, {String? baseUrl}) {
    return _RequestService(dio, baseUrl: baseUrl);
  }

  /// 测试连接
  @POST("/cy7/canyin/ordererreceive/mobiledevices/regdev")
  Future<String> regdev(@Body() String request);
}
