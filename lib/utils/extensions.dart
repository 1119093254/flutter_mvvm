
import 'dart:ui';


import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'log.dart';

/// 状态栏高度
double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}
/// 屏幕宽度
double getScreenWidth() {
  return window.physicalSize.width;
}
/// 屏幕高度
double getScreenHeight() {
  return window.physicalSize.height;
}

measureTimeCost(Function() func) {
  var start = DateTime.now().millisecondsSinceEpoch;
  func.call();
  var cost = DateTime.now().millisecondsSinceEpoch - start;
  printExt('$func cost $cost');
}

/// 模仿kotlin的apply(只是做不到直接使用内部变量，所以更贴近kotlin的run)
extension Apply<T> on T {
  T apply(Function(T) func) {
    func.call(this);
    return this;
  }
}

/// 字符串直接转化
extension Parser on String {
  int? toIntOrNull() {
    return int.tryParse(this);
  }
  double? toDoubleOrNull() {
    return double.tryParse(this);
  }
  String append(String? text) {
    return '${this}$text';
  }
  String insertAt(int position, String? text) {
    if(position < length && position >= 0) {
      var start = substring(0, position);
      var end = substring(position);
      return '$start${text??''}$end';
    }
    // 超出范围则加在最后
    else {
      return append(text);
    }
  }
  // 判断是否包含数字
  bool containsNumber() {
    final reg = RegExp(r'^-?[0-9.]+$');
    return reg.hasMatch(this);
  }
  // 判断是否全是数字
  bool isNumber() {
    try {
      int value = int.parse(this);
      return true;
    } catch(e) {
      return false;
    }
  }
  // 将手机号中间4位显示为*
  String toPrivateMobile() {
    String result = this;
    if (length >= 11){
      result = result.substring(0, length -8) + '****' + result.substring(length -4);
    }
    return result;
  }
}

/// 浮点数格式化
extension DoubleFormat on double {
  // 去掉末尾的0
  String withoutZero() {
    return Decimal.parse(toString()).toString();
  }

  // 精度相加
  double decimalAdd(double num) {
    return (Decimal.parse(toString()) + Decimal.parse(num.toString())).toDouble();
  }

  // 精度相减
  double decimalSub(double num) {
    return (Decimal.parse(toString()) - Decimal.parse(num.toString())).toDouble();
  }

  // 精度相乘
  double decimalMulti(double num) {
    return (Decimal.parse(toString()) * Decimal.parse(num.toString())).toDouble();
  }

  // 精度相除
  double decimalDiv(double num) {
    return (Decimal.parse(toString()) / Decimal.parse(num.toString())).toDouble();
  }
}

/// 浮点数格式化
extension NumFormat on num {
  // 去掉末尾的0
  String withoutZero() {
    return Decimal.parse(toString()).toString();
  }
}

/// 扩展list功能
extension ListExt<E> on List<E> {
  // firstWhere如果不存在会抛异常，用这个返回null（代码由firstWhere修改而来）
  E? firstOrNull(bool test(E element), {E orElse()?}) {
    for (E element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }
  // first如果没有是抛异常，用这个返回null
  E? firstItemOrNull() {
    try {
      return first;
    } catch(e) {
      return null;
    }
  }
  // first如果没有是抛异常，用这个返回null
  E? lastItemOrNull() {
    try {
      return last;
    } catch(e) {
      return null;
    }
  }

  ///list 参数求和
  num? sumBy(num f(E element)) {
    num sum = 0;
    for(var item in this) {
      sum += f(item);
    }
    return sum;
  }
}