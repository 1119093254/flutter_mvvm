
import 'dart:io';

import 'package:monbile_push_project/utils/platform.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {

  /// 获取外部存储根目录
  ///       getApplicationDocumentsDirectory()                    路径相当于 '/data/user/0/xx.xx.xx/app_flutter'
  ///       getTemporaryDirectory()                               路径相当于'/data/user/0/xx.xx.xx/cache'
  ///       getExternalStorageDirectory()             仅Android平台可用，路径相当于'/storage/emulated/0'外置存储根路径(Android 9开始是/storage/emulated/0/Android/data/包名/files)
  ///       getApplicationSupportDirectory()                      仅Ios平台可用
  static Future<String> getRootFolder() async {
    Directory? dir;
    if(PlatformUtils.isAndroid) {
      // 实际目录：/storage/emulated/0/Android/data/cn.com.tcsl.cy7_2.canyin7_flutter/files
      dir = await getExternalStorageDirectory();
    }
    else if(PlatformUtils.isIOS) {
      dir = await getApplicationSupportDirectory();
    }
    return dir?.path??'';
  }

  /// 创建文件目录
  static Future createDir(String path) async {
    print("createDir: $path");
    var dir = Directory(path);
    try {
      bool exists = await dir.exists();
      print("createDir exists=$exists");
      if (!exists) {
        await dir.create();
      }
    } catch (e) {
      print(e);
    }
  }

}