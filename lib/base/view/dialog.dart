import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/styles.dart';

Future<bool?> confirmCancel(String message, BuildContext context,
    {Function()? onConfirm}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text("确定")),
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text("取消")),
        ],
      );
    },
  );
}

Future<bool?> confirm(String message, BuildContext context,
    {Function()? onConfirm}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Text(message),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm?.call();
              },
              child: Text("确定")),
        ],
      );
    },
  );
}

Future<bool?> inputDialog(
    String message, BuildContext context, Function(String) onConfirm,
    {String? initText}) {
  var _controller = TextEditingController();
  _controller.text = initText ?? "";
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          height: 80,
          child: Center(
            child: Column(
              children: [
                NormalText16(message),
                TextField(
                  controller: _controller,
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm.call(_controller.text);
              },
              child: Text("确定")),
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text("取消")),
        ],
      );
    },
  );
}

abstract class OptionExtra {
  Widget widget();

  String value();

  listenStateChange();
}

Future<bool?> options(String title, List<String> options, BuildContext context,
    {Function(String)? onOption}) {
  List<Widget> widgets = [];
  for (String option in options) {
    widgets.add(SimpleDialogOption(
      child: NormalText16(option),
      onPressed: () {
        onOption?.call(option);
        Navigator.of(context).pop();
      },
    ));
  }
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: NormalText18(title),
        children: widgets,
      );
    },
  );
}

Widget baseDialog(
    {Widget? child,
    double? width,
    double? height,
    EdgeInsets? padding,
    double? radius,
    Color? bgColor}) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 10),
        child: Container(
          color: bgColor ?? Colors.white,
          width: width ?? 632,
          height: height ?? 632,
          padding: padding ?? EdgeInsets.all(16),
          child: child,
        ),
      ),
    ),
  );
}
