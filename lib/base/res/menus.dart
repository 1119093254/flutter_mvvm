
import 'package:flutter/material.dart';

/// actionbar右边的可点击按钮（图标、文字、带边框文字）
class BasePosAction {
  String? id;
  BasePosAction({this.id});
}

/// 直接平铺在actionbar上的文字按钮
class PosTextAction extends BasePosAction {
  String name;
  bool? withBorder;// 是否带边框
  bool? isFocus;// 带边框时使用，focus or normal状态
  double? rightPadding; // 不加默认是7.w, 目前只加在了右侧纯文字
  Function()? onClick;

  PosTextAction(this.name, {this.rightPadding,this.withBorder, this.isFocus, this.onClick, String? id}): super(id: id);
}

/// 直接平铺在actionbar上的图片按钮
class PosIconAction extends BasePosAction {
  String iconRes;
  double? height;
  double? width;
  double? padding;
  bool? ifOriginalColor;
  Function()? onClick;
  String? label;

  PosIconAction(this.iconRes, {this.onClick, this.width, this.padding, this.ifOriginalColor = false ,this.height, this.label, String? id}): super(id: id);
}

/// 弹出式菜单
class PosMenuItem {
  String name;
  Widget? icon;
  Function()? onClick;
  ///达到先执行点击事件  再执行closePage的作用，首次使用防止支付界面onResume重复刷账单作用
  Function()? itemOnClicksync;

  PosMenuItem(this.name, {this.icon, this.onClick, this.itemOnClicksync});
}

/// 下拉弹出菜单替换的依附按钮
class PosPopupMenuAnchor {
  // 图标与文字两者取其一
  String? iconRes;// 替换...的图标资源
  String? text;// 替换...的文字资源
  bool? textWithBorder;
  double? height;
  double? width;
  String? label;

  PosPopupMenuAnchor({this.iconRes, this.text, this.textWithBorder, this.height, this.width, this.label}); // 文字类型时使用，是否有边框样式
}