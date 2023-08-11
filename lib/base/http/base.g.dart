// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequest _$BaseRequestFromJson(Map<String, dynamic> json) => BaseRequest(
      devType: json['devType'],
    )..versionFlag = json['versionFlag'] as int;

Map<String, dynamic> _$BaseRequestToJson(BaseRequest instance) =>
    <String, dynamic>{
      'devType': instance.devType,
      'versionFlag': instance.versionFlag,
    };

BaseUserRequest _$BaseUserRequestFromJson(Map<String, dynamic> json) =>
    BaseUserRequest(
      devType: json['devType'],
    )..versionFlag = json['versionFlag'] as int;

Map<String, dynamic> _$BaseUserRequestToJson(BaseUserRequest instance) =>
    <String, dynamic>{
      'devType': instance.devType,
      'versionFlag': instance.versionFlag,
    };

BaseUserParamRequest<T> _$BaseUserParamRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseUserParamRequest<T>(
      devId: json['devId'] as String?,
      devCode: json['devCode'] as String?,
      userId: json['userId'] as int?,
      params: _$nullableGenericFromJson(json['params'], fromJsonT),
    )..versionFlag = json['versionFlag'] as int;

Map<String, dynamic> _$BaseUserParamRequestToJson<T>(
  BaseUserParamRequest<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'devId': instance.devId,
      'devCode': instance.devCode,
      'userId': instance.userId,
      'params': _$nullableGenericToJson(instance.params, toJsonT),
      'versionFlag': instance.versionFlag,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>(
      result: json['result'] as int?,
      errorCode: json['errorCode'] as int?,
      msg: json['msg'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': instance.result,
      'errorCode': instance.errorCode,
      'msg': instance.msg,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

BaseListResponse<T> _$BaseListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseListResponse<T>(
      result: json['result'] as int?,
      errorCode: json['errorCode'] as int?,
      msg: json['msg'] as String?,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    );

Map<String, dynamic> _$BaseListResponseToJson<T>(
  BaseListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': instance.result,
      'errorCode': instance.errorCode,
      'msg': instance.msg,
      'data': instance.data?.map(toJsonT).toList(),
    };
