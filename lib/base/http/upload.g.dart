// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadRequest _$UploadRequestFromJson(Map<String, dynamic> json) =>
    UploadRequest(
      code: json['code'] as String?,
      version: json['version'] as String?,
      subCode: json['subCode'] as String?,
      subVersion: json['subVersion'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      createTime: json['createTime'] as String?,
      workCode: json['workCode'] as String?,
      title: json['title'] as String?,
      tel: json['tel'] as String?,
      content: json['content'] as String?,
      file: json['file'] as String?,
      fileName: json['fileName'] as String?,
      creatorName: json['creatorName'] as String?,
    );

Map<String, dynamic> _$UploadRequestToJson(UploadRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'version': instance.version,
      'subCode': instance.subCode,
      'subVersion': instance.subVersion,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'createTime': instance.createTime,
      'workCode': instance.workCode,
      'title': instance.title,
      'tel': instance.tel,
      'content': instance.content,
      'file': instance.file,
      'fileName': instance.fileName,
      'creatorName': instance.creatorName,
    };

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    UploadResponse(
      msg: json['msg'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'success': instance.success,
    };
