import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable()
class BaseRequest {
  final int devType = 4;

  int versionFlag = 2;

  BaseRequest({ devCode, devType});

  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);
}

@JsonSerializable()
class BaseUserRequest {
  final int devType = 4;
  int versionFlag = 2;// 移动银台2.0传2
  BaseUserRequest({ userId, devType});

  Map<String, dynamic> toJson() => _$BaseUserRequestToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class BaseUserParamRequest<T> {
  final String? devId;
  final String? devCode;
  final int? userId;
  final T? params;
  int versionFlag = 2;// 移动银台2.0传2
  BaseUserParamRequest({this.devId, this.devCode, this.userId, this.params});

  factory BaseUserParamRequest.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$BaseUserParamRequestFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseUserParamRequestToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  final int? result;
  final int? errorCode;
  final String? msg;
  final T? data;

  BaseResponse({this.result, this.errorCode, this.msg, this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> {
  final int? result;
  final int? errorCode;
  final String? msg;
  final List<T>? data;

  BaseListResponse({this.result, this.errorCode, this.msg, this.data});

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) =>
      _$BaseListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseListResponseToJson(this, toJsonT);
}
