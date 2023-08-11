
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/log.dart';

/// 路由管理
class MyNavigator {

  static final MyNavigator _instance = MyNavigator._internal();

  static final Duration duration = Duration(milliseconds: 200);// GetX的defaultTransitionDuration是300ms，调整为200ms

  factory MyNavigator() {
    return _instance;
  }

  // final navGK = new GlobalKey<NavigatorState>();

  MyNavigator._internal();

  void newPage(Widget page, {String? routeName, bool preventDuplicates = true, bool? removeAllBefore,dynamic arguments}) {
    routeName ??= page.runtimeType.toString();
    if(removeAllBefore == true) {
      _pushAndRemoveUntil(page, routeName: routeName,arguments: arguments);
    }
    else {
      _push(page, routeName: routeName,arguments: arguments, preventDuplicates: preventDuplicates);
    }
  }

  /// 打开新页面，添加
  void _push(Widget page, {String? routeName, bool preventDuplicates = true, dynamic arguments}) {
    routeName ??= page.runtimeType.toString();
    var state = Get.key.currentState;
    var route = Get.currentRoute;
    print('_push $routeName');
    Get.to(() => page, routeName: routeName, arguments: arguments, duration: duration, preventDuplicates: preventDuplicates);
    // navGK.currentState?.push(
    //   MaterialPageRoute(
    //     builder: (context) => page,
    //     settings: RouteSettings(name: routeName),
    //   ),
    // );
  }
  /// 打开新页面，并等待返回值
  Future<T?>? pushForResult<T>(Widget page, {String? routeName, bool preventDuplicates = true, dynamic arguments}) {
    routeName ??= page.runtimeType.toString();
    var state = Get.key.currentState;
    var route = Get.currentRoute;
    print('pushForResult $routeName');
    return Get.to(() => page, routeName: routeName, preventDuplicates: preventDuplicates, arguments: arguments);
    // routeName ??= page.toStringShort();
    // return navGK.currentState?.push<T>(
    //   MaterialPageRoute(
    //     builder: (context) => page,
    //     settings: RouteSettings(name: routeName),
    //   ),
    // );
  }

  /// 路由返回携带参数
  void popResult(dynamic result) {
    Get.back(result: result);
    // navGK.currentState?.pop(result);
  }

  /// 打开新页面，并关闭之前所有页面
  void _pushAndRemoveUntil(Widget page, {String? routeName,dynamic arguments}) {
    routeName ??= page.runtimeType.toString();
    print('_pushAndRemoveUntil $routeName');
    Get.key.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: routeName,arguments: arguments),
      ),
      (route) => false,
    );
  }

  /// 返回到指定页面（关闭指定routeName页面顶面的所有页面）
  void popUntil(String routeName) {
    Get.key.currentState?.popUntil((route) {
      // 这里有些不解，前面的几个push方法都是采用page.runtimeType.toString()作为routeName，print时都是不带"/"符号的，
      // 但是在pop的时候，route.settings.name打印出来，TablePage是不带"/"符号的，后面所有的page又都是带"/"符号的，
      // 因此在这里只好先判断route.settings.name是不是带"/"符号，再决定目标routeName要不要加上"/"
      var target = routeName;
      if(route.settings.name?.startsWith('/') == true) {
        target = '/$routeName';
      }
      printExt('popUntil $target, current: ${route.settings.name}');
      return route.settings.name == target;
    });
  }

  /// 获取当前页面的context
  BuildContext? currentContext() {
    return Get.context;
  }

  /// 关闭当前页面
  void closePage() {
    printExt("exit");
    Get.back();
  }

}