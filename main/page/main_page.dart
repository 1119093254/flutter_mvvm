import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:monbile_push_project/base/navigator.dart';
import 'package:monbile_push_project/base/res/menus.dart';
import 'package:monbile_push_project/base/res/resources.dart';
import 'package:monbile_push_project/base/view/actionbar.dart';
import 'package:monbile_push_project/base/view/dialog.dart';
import 'package:monbile_push_project/base/vm/state.dart';
import 'package:monbile_push_project/utils/extensions.dart';
import 'package:monbile_push_project/utils/log.dart';
import 'package:monbile_push_project/utils/platform.dart';

import 'main_page_viewmodel.dart';

class MainPagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends ViewModelState<MainPagePage, MainPageViewModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void onStart() {
    super.onStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PosActionBar(
        title: getString().copy_right,
        leftActions: [
          PosTextAction(getString().cancel,
              onClick: () => MyNavigator().closePage())
        ],
      ),
      body: Container(),
      backgroundColor: MyColor.main_grey,
    );
  }

  @override
  MainPageViewModel createViewModel() {
    return MainPageViewModel();
  }
}

/// 打印异常、记录异常到日志、
catchError(String type, dynamic error, StackTrace? stack) {
  var errorText = error.toString();
  // 布局超出这类的异常不需要记录
  if (errorText.startsWith('A RenderFlex overflowed')) {
    return;
  }
  // websocket断开连接不需要记录
  if (errorText.startsWith('Bad state: StreamSink is closed')) {
    return;
  }
  var msg = '[catchError]type:$type error:$error,\n stack: $stack';
  printExt(msg);
  // TODO IOS目前bugly记录不了自定义上传信息，先记录到本地日志文件中
  if (PlatformUtils.isIOS) {
    MyLogger().log(msg);
  }
  // android记录到bugly平台
  else {
    // Bugly平台不支持Flutter，那就转换一下思路，利用原生API的CrashReport.postCatchedException方法，将捕捉到的Flutter异常交给原生，原生经过格式化后作为“错误分析”模块上传到bugly平台
    // 这样就能在bugly平台上的“错误分析”里看到和原生类似的崩溃信息统计了
    //MainChannel().logError(LogBean(type: type, error: errorText, trace: stack.toString()));
  }
  // 非正式模式直接弹框提示
  if (!kReleaseMode) {
    Get.context?.apply((context) {
      try {
        confirm(msg, context);
      } catch (e) {
        print(e);
      }
    });
  }
}
