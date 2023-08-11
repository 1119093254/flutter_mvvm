
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../generated/l10n.dart';
import 'navigator.dart';

/// 提供访问字符串、显示等待框、toast弹框
mixin BasePage {

  S getString() {
    return S.of(MyNavigator().currentContext()!);
  }

  /// EasyLoading.show是返回的Future，需要await，否则启动会卡顿
  showLoading(bool show) async {
    if(show) {
      await EasyLoading.show();
    }
    else {
      await EasyLoading.dismiss();
    }
  }

  ///收起键盘
  hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(MyNavigator().currentContext()!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  showMessage(String msg) async {
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.CENTER);
  }

}