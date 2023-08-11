import 'dart:convert';
import 'dart:developer';
import 'dart:io';



import 'package:archive/archive_io.dart';
import 'package:monbile_push_project/base/http/upload.dart';
import 'package:monbile_push_project/utils/file_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'format.dart';
import 'product_provider.dart';

/// 日志记录
class MyLogger {

  static final MyLogger _instance = MyLogger._internal();

  factory MyLogger() {
    return _instance;
  }

  MyLogger._internal();

  Future init() async {
    await FileUtil.createDir(ProductProvider().logFolder);
  }

  /// 记录普通日志
  log(String msg) {
    printExt(msg);
    writeToFile(msg);
  }

  /// 记录格式化的http请求
  logHttp(HttpData data) {
    var msg = _formatHttpData(data);
    printExt(msg);
    writeToFile(msg);
  }

  String _formatHttpData(HttpData data) {
    var msg = "[url]${data.url}\n[request-time]${data.requestTime}\n[request]${data.request}";
    if(data.response != null) {
      msg = "$msg\n[response]${data.response}";
    }
    if(data.error != null) {
      msg = "$msg\n[error]${data.error}";
    }
    return msg;
  }

  printHttp(HttpData data) {
    printExt(_formatHttpData(data));
  }

  Future writeToFile(String msg) async {
    // 日志按日期分文件
    var filePath = "${ProductProvider().logFolder}/${formatOnlyDate(DateTime.now(), split: '')}.trace";
    var file = File(filePath);
    bool exist = await file.exists();
    if(!exist) {
      await file.create();
    }
    // 记录日志属于完全无序的异步操作，多个异步请求会同时写文件，因此必须采用randomAccessFile
    // 因为其有文件锁的机制，如果只用file.writeAsString方法，当同一时间多个异步请求同时写入文件会造成部分内容被覆盖（实测）
    // await file.writeAsString(line)
    var randomAccessFile = file.openSync(mode: FileMode.writeOnlyAppend);
    String line = "-- ${formatDateAndTime(DateTime.now())} --\n$msg\n";
    randomAccessFile.writeStringSync(line);
    randomAccessFile.closeSync();
  }

  /// 将日志添加到压缩包
  Future zipLogs() async {
    var zipPath = ProductProvider().logZipPath;
    var file = File(zipPath);
    if(file.existsSync()) {
      file.deleteSync();
    }
    var logPath = ProductProvider().logFolder;
    var encoder = ZipFileEncoder();
    encoder.create(zipPath);
    encoder.addDirectory(Directory(logPath));
    encoder.close();
  }

  /// 组装上传数据，文件进行base64加密
  Future<UploadRequest> getUploadRequest(String message, String phone) async {
    File file = File(ProductProvider().logZipPath);
    var shopId = ProductProvider().shopId;
    var shopName = ProductProvider().shopName;
    // 工单号必须保持 83-220629-001 的格式，否则会返回系统异常
    var workCode = '$shopId-${formatYYMMDD(DateTime.now())}-001';
    var date = formatDateAndTime(DateTime.now());
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return UploadRequest(
      code: '4101120149',
      subCode: '1',
      version: version,
      subVersion: version,
      shopId: shopId,
      shopName: shopName,
      createTime: date,
      workCode: workCode,
      title:"",
      content: message,
      tel: phone,
      fileName: 'logFile.zip',
      creatorName: '移动银台Pro${ProductProvider().devCode}',
      file: base64Encode(file.readAsBytesSync())
    );
  }
}

class HttpData {
  String? requestTime;
  String? request;
  String? url;
  String? response;
  String? error;

  HttpData({this.requestTime, this.request, this.url, this.response, this.error});
}

var isPrint = true;

printExt(Object? object) {
  if(isPrint) {
    var time = formatDateAndTime(DateTime.now());
    log('$time $object');
  }
}