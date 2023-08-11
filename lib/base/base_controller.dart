import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../generated/l10n.dart';
import 'http/base.dart';
import 'exceptions.dart';
import 'handler.dart';
import 'http/response_flat.dart';
import 'vm/livedata.dart';
import 'navigator.dart';

class BaseController {
  List<StreamSubscription> composite = [];

  SimpleLiveData<String> showInfoDialog = SimpleLiveData();

  S getString() {
    return S.of(MyNavigator().currentContext()!);
  }

  dispose() {
    for (StreamSubscription subscription in composite) {
      subscription.cancel();
    }
    composite.clear();
  }

  addComposite(StreamSubscription subscription) {
    composite.add(subscription);
  }

  /// EasyLoading.show是返回的Future，需要await，否则启动会卡顿
  Future showLoading(bool show) async {
    if (show) {
      await EasyLoading.show();
    } else {
      await EasyLoading.dismiss();
    }
  }

  Future showMessage(String msg) async {
    Fluttertoast.showToast(
        msg: msg, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 2);
  }

  /// 从baseError中只提取出message，不做任何额外处理
  collectMessageFromBaseError(dynamic error, Function(String?) collector) {
    if (error is DioError) {
      DioErrorHandler.handleError(error, allDispatcher: (error) {
        collector.call(error.message);
        return false;
      });
    } else if (error is ServerError) {
      collector.call(error.message);
    } else {
      collector.call(error.toString());
    }
  }

  ///errorShowDialog 错误是否以dialog形式展示
  baseError(
    dynamic error, {
    Function(String?)? onAuthError, // 需要授权
    Function(String?)? onSettled, // 客位已结算
    Function(ServerError)? dispatchServerError, // 自行处理服务端异常
    bool? errorShowDialog = false, // 错误信息以info确定框形式展示，默认为toast信息
  }) {
    if (error is DioError) {
      DioErrorHandler.handleError(error, allDispatcher: (error) {
        showMessage(error.message ?? "");
        return false;
      });
    } else if (error is ServerError) {
      showMessage(error.toString());
    } else {
      showMessage(error.toString());
    }
  }

  /// 封装fromFuture形式的流式任务，并制定默认异常处理器
  runStream<T>(Future<T> task,
      {bool? withLoading,
      void Function(T event)? onData,
      Function(dynamic)? onError,
      void Function()? onDone,
      bool? cancelOnError}) async {
    if (withLoading == true) {
      // EasyLoading.show是返回的Future，需要await，否则启动会卡顿
      await showLoading(true);
    }
    var subscription = Stream.fromFuture(task).listen((event) {
      if (withLoading == true) {
        showLoading(false);
      }
      onData?.call(event);
    },
        onError: onError ??
            ((error) {
              if (withLoading == true) {
                showLoading(false);
              }
              baseError(error);
            }),
        cancelOnError: cancelOnError);
    composite.add(subscription);
    subscription.onDone(() {
      composite.remove(subscription);
      onDone?.call();
    });
  }

  /// 在runStream的基础上专门处理BaseResponse<T>到T的转换
  runBaseStream<T>(
    Future<BaseResponse<T>> task, {
    bool? withLoading, // 是否显示等待框
    Function(T? event)? onData, // 成功数据，只接收T
    Function(BaseResponse<T>? event)?
        onBaseResponseData, // 成功数据，接收BaseResponse<T>
    Function()? onDone,
    bool? cancelOnError,
    Function? onError,
    Function(String?)? onAuthError, // 接收授权错误
    Function(String?)? onSettled, // 客位已结算
    Function(ServerError)? dispatchServerError, // 接收所有服务端异常
    bool? errorShowDialog = false, // 统一错误信息由info确认框展示，默认为toast信息
  }) async {
    if (withLoading == true) {
      // EasyLoading.show是返回的Future，需要await，否则启动会卡顿
      await showLoading(true);
    }
    Function realOnError = onError ??
        ((error) {
          if (withLoading == true) {
            showLoading(false);
          }
          baseError(error,
              onAuthError: onAuthError,
              onSettled: onSettled,
              dispatchServerError: dispatchServerError,
              errorShowDialog: errorShowDialog);
        });
    StreamSubscription? subscription;
    if (onBaseResponseData != null) {
      subscription = Stream.fromFuture(task).listen(
        (event) {
          if (withLoading == true) {
            showLoading(false);
          }
          onBaseResponseData.call(event);
        },
        onError: realOnError,
        cancelOnError: cancelOnError,
      );
    } else {
      subscription = Stream.fromFuture(task)
          .map((event) => flatResponse(event))
          .listen((event) {
        if (withLoading == true) {
          showLoading(false);
        }
        onData?.call(event);
      }, onError: realOnError, cancelOnError: cancelOnError);
    }
    composite.add(subscription);
    subscription.onDone(() {
      composite.remove(subscription);
      onDone?.call();
    });
  }

  Future<T?> asFuture<T>(T? Function() function) async {
    var result = function.call();
    return result;
  }
}
