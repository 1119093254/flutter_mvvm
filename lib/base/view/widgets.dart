
import 'package:flutter/material.dart';

/// 垂直方向上的边距
class MarginVer extends Padding {
  final double height;
  MarginVer(this.height)
      : super(padding: EdgeInsets.only(top: height));

}

/// 水平方向上的边距
class MarginHor extends Padding {
  final double width;
  MarginHor(this.width)
      : super(padding: EdgeInsets.only(left: width));

}

/// 自定义normal, press, ripple背景色的按钮
class ColorButton extends TextButton {
  static const defColor = Colors.grey;

  ColorButton(Widget text, {
    required VoidCallback? onPressed,
    Color? color,
    Color? pressColor,
    Color? rippleColor,
  }): super (
    child: text,
    onPressed: onPressed,
    style: ButtonStyle(
      // 按钮上字体与图标
      // foregroundColor: yellowButton(),
      backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
            if (pressColor != null && states.contains(MaterialState.pressed)) {
              return pressColor;
            }
            return color??defColor;
          }
      ),
      //设置水波纹颜色
      overlayColor: MaterialStateProperty.all(rippleColor??defColor),
    ),
  );
}

/// 宽高固定，fitCenter的图标按钮
class ImageButton {
  static Widget sizeFit(double width, double height, {String? image, GestureTapCallback? onTap, double? padding, Color? imageColor,GlobalKey? key}) {
    var realPadding = padding??0;
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(realPadding),
        child: Image(image: AssetImage(image??''),
          width: width,
          height: height,
          fit: BoxFit.contain,
          color: imageColor,
        ),
      ),
    );
  }

  /// 图标尺寸固定，扩展自定义触摸边距
  static Widget extendIcon({double? iconWidth, double? iconHeight, String? imageSrc, GestureTapCallback? onTap, double touchPadding = 0, Color? imageColor,GlobalKey? key}) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(touchPadding),
        child: Image(image: AssetImage(imageSrc??''),
          width: iconWidth,
          height: iconHeight,
          fit: BoxFit.contain,
          color: imageColor,
        ),
      ),
    );
  }
}
