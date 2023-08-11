
import 'package:package_info_plus/package_info_plus.dart';

class MyPackageInfo {

  static late PackageInfo packageInfo;

  static init() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  static String getVersion() {
    return packageInfo.version;
  }

  static String getPackageName() {
    return packageInfo.packageName;
  }

  static String getAppName() {
    return packageInfo.appName;
  }

  static String getBuildNumber() {
    return packageInfo.buildNumber;
  }
}