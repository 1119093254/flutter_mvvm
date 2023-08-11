import 'dart:ui';


import 'dimens.dart';
import 'resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NormalText18 extends Text {
  NormalText18(String data)
      : super(
          data,
          style: TextStyleNormal18(),
        );
}

class SubText14 extends Text {
  SubText14(String data, {int? maxLines, TextOverflow? overflow})
      : super(data,
            style: TextStyleSub14(), maxLines: maxLines, overflow: overflow);
}

class TextStyleNormal18 extends TextStyle {
  TextStyleNormal18()
      : super(fontSize: MyDimen().text_18, color: MyColor.text_normal);
}

class TextStyleSub16 extends TextStyle {
  TextStyleSub16()
      : super(fontSize: MyDimen().text_normal, color: MyColor.text_sub);
}

class TextStyleMainGreen14 extends TextStyle {
  TextStyleMainGreen14({FontWeight? fontWeight})
      : super(
            fontSize: MyDimen().text_second,
            color: MyColor.main_green,
            fontWeight: fontWeight);
}

class TextStyleSub14 extends TextStyle {
  TextStyleSub14()
      : super(fontSize: MyDimen().text_second, color: MyColor.text_sub);
}

class TextStyleNormal14 extends TextStyle {
  TextStyleNormal14()
      : super(fontSize: MyDimen().text_second, color: MyColor.text_normal);
}

class WhitText12 extends Text {
  WhitText12(String data, {int? maxLines})
      : super(
          data,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12.w, color: Colors.white),
        );
}

class Text18 extends TextSimple {
  Text18(
      String data, {
        int? maxLines,
        Color? color,
        FontWeight? fontWeight,
        TextAlign? textAlign,
        double? lineHeight,
      }) : super(
    data,
    maxLines: maxLines,
    textAlign: textAlign,
    fontWeight: fontWeight,
    color: color,
    fontSize: 18.w,
    lineHeight: lineHeight,
  );
}

class Text16 extends TextSimple {
  Text16(
    String data, {
    int? maxLines,
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    double? lineHeight,
  }) : super(
          data,
          maxLines: maxLines,
          textAlign: textAlign,
          fontWeight: fontWeight,
          color: color,
          fontSize: 16.w,
          lineHeight: lineHeight,
        );
}

class Text15 extends TextSimple {
  Text15(String data,
      {int? maxLines,
        Color? color,
        FontWeight? fontWeight,
        TextAlign? textAlign,
        double? lineHeight})
      : super(
    data,
    maxLines: maxLines,
    textAlign: textAlign,
    fontWeight: fontWeight,
    color: color,
    lineHeight: lineHeight,
    fontSize: 15.w,
  );
}

class Text14 extends TextSimple {
  Text14(String data,
      {int? maxLines,
      Color? color,
      FontWeight? fontWeight,
      TextAlign? textAlign,
      double? lineHeight})
      : super(
          data,
          maxLines: maxLines,
          textAlign: textAlign,
          fontWeight: fontWeight,
          color: color,
          lineHeight: lineHeight,
          fontSize: 14.w,
        );
}

class Text13 extends TextSimple {
  Text13(String data,
      {int? maxLines,
        Color? color,
        FontWeight? fontWeight,
        TextAlign? textAlign,
        double? lineHeight})
      : super(
    data,
    maxLines: maxLines,
    textAlign: textAlign,
    fontWeight: fontWeight,
    color: color,
    lineHeight: lineHeight,
    fontSize: 13.w,
  );
}

class Text12 extends TextSimple {
  Text12(String data,
      {int? maxLines,
      Color? color,
      FontWeight? fontWeight,
      TextAlign? textAlign,
      double? lineHeight})
      : super(
          data,
          maxLines: maxLines,
          textAlign: textAlign,
          fontWeight: fontWeight,
          color: color,
          fontSize: 12.w,
          lineHeight: lineHeight,
        );
}

class Text10 extends TextSimple {
  Text10(String data,
      {int? maxLines,
      Color? color,
      FontWeight? fontWeight,
      TextAlign? textAlign})
      : super(
          data,
          maxLines: maxLines,
          textAlign: textAlign,
          fontWeight: fontWeight,
          color: color,
          fontSize: 10.w,
        );
}

class TextSimple extends Text {
  TextSimple(String data,
      {int? maxLines,
      Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      TextAlign? textAlign,
      double? lineHeight})
      : super(
          data,
          maxLines: maxLines,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: fontSize,
              fontFeatures: const [FontFeature.tabularFigures()],
              color: color,
              fontWeight: fontWeight,
              height: lineHeight),
        );
}

ButtonStyle btnHomeSetting() {
  return ButtonStyle(
    shape: MaterialStateProperty.resolveWith((states) =>
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w))),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return Color(0xffD0E8EA);
    }),
    //设置水波纹颜色
    overlayColor: MaterialStateProperty.all(MyColor.ripple_color),
  );
}

ButtonStyle btnLogin({double radius = 8}) {
  return ButtonStyle(
    shape: MaterialStateProperty.resolveWith((states) =>
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius.w))),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return Color(0x4d0babb9);
      }
      return Color(0xff0BABB9);
    }),
    //设置水波纹颜色
    overlayColor: MaterialStateProperty.all(MyColor.ripple_color),
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
        borderRadius: BorderRadius.circular(5.w),
        child: Container(
          color: bgColor ?? Colors.white,
          width: 327.w,
          height: height,
          padding: padding ?? EdgeInsets.all(16.w),
          child: child,
        ),
      ),
    ),
  );
}

/// 通用绿色圆角按钮
Widget commonRoundButton(String text,
    {double? width,
    double? height,
    double? radius,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    Color? borderColor,
    Color? textColor,
    TextAlign? textAlign,
    Function()? onPressed}) {
  MaterialStateProperty<BorderSide?>? side;
  if(borderColor != null) {
    side = MaterialStateProperty.all(BorderSide(color: borderColor, width: 1));
  }
  return Container(
    width: width,
    height: height ?? 42.h,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: side,
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        // 如果不设置会有默认的边距，造成文字显示不全（尤其是高度上）
        shape: MaterialStateProperty.resolveWith((states) =>
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 21.w))),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return color ?? const Color(0xff0BABB9);
        }),
        overlayColor: MaterialStateProperty.all(MyColor.ripple_color),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontWeight: fontWeight ?? FontWeight.bold,
            fontSize: fontSize ?? 18.w,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    ),
  );
}

/// 菜单栏上的图标
Widget blackActionBarIcons(String asset, {Key? key, Function()? onPressed}) {
  return IconButton(
    key: key,
    constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
    onPressed: onPressed,
    icon: Image.asset(
      asset,
      color: MyColor.actionbar_icon,
    ),
    iconSize: 20.w,
    padding: EdgeInsets.all(8.w),
    splashRadius: 30.w,
    // splashColor: Colors.transparent,
    // highlightColor: Colors.transparent,
  );
}

///带圆角背景的Container
Widget ContainerCircle(
    {double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    AlignmentGeometry? alignment,
    Widget? child,
    double radius = 0,
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
    BoxBorder? border}) {
  if (radius != 0) {
    topLeft = radius;
    topRight = radius;
    bottomLeft = radius;
    bottomRight = radius;
  }
  return Container(
      margin: margin,
      width: width,
      height: height,
      child: child,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight)),
      ));
}

Decoration dialogDecoration() {
  return BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(7.w));
}

/// 带文字的checkbox，点击事件扩大到文字
Widget posCheckBoxText(bool value,
    {Widget? text, bool? disable, Function(bool?)? onChanged}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
        side: BorderSide(
          color: MyColor.divider,
        ),
        activeColor: MyColor.main_green,
      ),
      if (text != null)
        GestureDetector(
          onTap: () {
            bool target = !value;
            onChanged?.call(target);
          },
          child: text,
        ),
    ],
  );
}



Widget posDivider() {
  return Divider(
    height: 1.h,
    thickness: 1.h,
    color: MyColor.divider,
  );
}

Widget dialogTitleBar({String? title, Function()? onClose}) {
  return SizedBox(
    height: 60.h,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
              padding: EdgeInsets.all(15.w),
              iconSize: 22.w,
              onPressed: onClose,
              icon: Image.asset('assets/img/ic_close_dialog.png')
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text16(title??'', color: MyColor.text_normal,),
        ),
      ],
    ),
  );
}

Widget methodTag(Widget child) {
  return Container(
    // alignment: Alignment.bottomLeft,// 设置align之后，整个Container需要包裹在Row中并设置MainAxisSize.min才能自适应宽度（处于Wrap,ListView等包裹下的情况，如果Container不是这些父组件的child，则不必包裹Row）
    padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.w),
      color: MyColor.tag_method_bg,
    ),
    child: child,
  );
}

Widget serverWayTag(String serveWay) {
  return Container(
    // alignment: Alignment.bottomLeft,// 设置align之后，整个Container需要包裹在Row中并设置MainAxisSize.min才能自适应宽度（处于Wrap,ListView等包裹下的情况，如果Container不是这些父组件的child，则不必包裹Row）
    padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.w),
      color: MyColor.tag_serve_way_bg,
    ),
    child: Text12(serveWay, color: MyColor.tag_serve_way_text,),
  );
}

/// 在红圈里的数量
Widget circleCount(String text, {Key? key}) {
  return Row(
    mainAxisSize: MainAxisSize.min,// // 当Container在ListView中时，只有嵌套一层Row，并设置mainAxisSize: MainAxisSize.min，才能自适应内部控件的宽度，否则会铺满
    children: [
      Container(
        key: key,
        constraints: BoxConstraints(
            minWidth: 17.w,
            minHeight: 17.w,
            maxHeight: 17.w),
        decoration: BoxDecoration(
          color: MyColor.redText,
          borderRadius: BorderRadius.circular(8.5.w),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 3.w, right: 3.w),
        child: Text12(
          text,
          color: Colors.white,
        ),
      )
    ],
  );
}
class NormalText16 extends Text {
  NormalText16(String data): super (
    data,
    style: TextStyleNormal16(),
  );
}



class TextStyleNormal16 extends TextStyle {
  TextStyleNormal16({FontWeight? fontWeight}): super (
      fontSize: LibDimen.text_normal,
      color: MyColor.text_normal,
      fontWeight: fontWeight
  );
}


Widget checkBoxText(String text, bool value, {TextStyle? textStyle, bool? disable, Function(bool?)? onChanged}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Checkbox(
        value: value,
        onChanged: onChanged,
      ),
      Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle??TextStyleNormal16(),
      ),
    ],
  );
}

Widget testButton({required VoidCallback? onPressed, required String text}) {
  return TextButton(
    onPressed: onPressed,
    style: ButtonStyle(
      shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.w))),
      backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
            return Color(0xffD0E8EA);
          }
      ),
      //设置水波纹颜色
      overlayColor: MaterialStateProperty.all(Color(0x33000000)),
    ),
    child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Text(text,
        style: const TextStyle(
          fontSize: 13,
          color: MyColor.text_normal,
        ),
      ),
    ),
  );
}

/// 统一使用PosActionBar
@deprecated
AppBar commonAppBar(
    {String? title,Color textColor = MyColor.text_normal,Color backgroundColor = MyColor.actionbar_bg,Color backIconColor = Colors.black, Function()? onBack, Widget? flexibleSpace, bool ifRemoveBackIcon = false,Widget? backWidget, List<Widget>? rightWidget}) {
  return AppBar(
    title: AppBarTitle(title,textColor),
    backgroundColor: backgroundColor,
    toolbarHeight: LibDimen.titlebar_height,
    // 如果不设置，底部会有1像素去不掉的分割线
    leading: onBack == null
        ? null
        : SizedBox(
      width: 24.w,
      height: 24.w,
      child: ifRemoveBackIcon ? Container() : backWidget ?? IconButton(
          onPressed: onBack,
          iconSize: 13.w,
          icon: Icon(Icons.arrow_back_ios, color: backIconColor)),
    ),
    centerTitle: true,
    elevation: 0,
    flexibleSpace: Column(
      children: [
        SizedBox(height: 20.w),
        if (flexibleSpace != null) flexibleSpace
      ],
    ),
    actions: rightWidget??[],
    // shadowColor: ,
  );
}
class AppBarTitle extends Text {
  AppBarTitle(String? data, Color textColor)
      : super(
    data ?? "",
    style: TextAppBarTitle(textColor),
  );
}
class TextAppBarTitle extends TextStyle {
  TextAppBarTitle(Color textColor)
      : super(
    fontSize: LibDimen.text_title,
    color: textColor,
    // fontWeight: FontWeight.bold,
  );
}
