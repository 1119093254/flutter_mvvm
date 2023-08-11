import 'package:json_annotation/json_annotation.dart';
part 'upload.g.dart';

@JsonSerializable()
class UploadRequest {
  final String? code;
  final String? version;
  final String? subCode;
  final String? subVersion;
  final String? shopId;
  final String? shopName;
  final String? createTime;
  final String? workCode;
  final String? title;
  final String? tel;
  final String? content;
  final String? file;
  final String? fileName;
  final String? creatorName;

  UploadRequest({
    this.code,
    this.version,
    this.subCode,
    this.subVersion,
    this.shopId,
    this.shopName,
    this.createTime,
    this.workCode,
    this.title,
    this.tel,
    this.content,
    this.file,
    this.fileName,
    this.creatorName});

  factory UploadRequest.fromJson(Map<String, dynamic> json) => _$UploadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadRequestToJson(this);
}

@JsonSerializable()
class UploadResponse {
  final String? msg;
  final bool? success;

  UploadResponse({this.msg, this.success});

  factory UploadResponse.fromJson(Map<String, dynamic> json) => _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);
}