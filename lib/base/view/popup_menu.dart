import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monbile_push_project/utils/extensions.dart';

import '../navigator.dart';
import '../res/menus.dart';
import '../res/styles.dart';
import 'bubble.dart';

/// desc: 弹出菜单。如果没有anchorWidget则会自动采用标准的更多菜单按钮
/// @author: 景阳
/// @date: 2022/8/23 8:41
class PosPopupMenu extends StatelessWidget {

  final keyIcon = GlobalKey();

  Widget? anchorWidget;
  List<PosMenuItem>? menus;

  Function()? itemOnClick;

  PosPopupMenu({Key? key, this.anchorWidget, this.menus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _wrapAnchorWidget(context)??blackActionBarIcons('assets/img/ic_menu_more.png', key: keyIcon, onPressed: () => _onClickWidget(context));
  }

  _onClickWidget(BuildContext context) {
    RenderBox? box = keyIcon.currentContext?.findRenderObject() as RenderBox?;
    box?.apply((it) {
      Size size = it.size;
      Offset position = it.localToGlobal(Offset.zero);
      Offset anchor = Offset(position.dx + size.width / 2, position.dy + size.height);
      // 重置
      itemOnClick = null;
      // menu item点击后执行的异步或同步会阻塞关闭弹框的动画造成卡顿，现象，因此将点击事件的回调延迟到showDialog Future执行完毕后
      // 但实际上即便这样处理了，click关联的异步事件还是会卡顿关闭动画。因此可以考虑在对应的事件前加延时处理
      show(context, anchor).then((value) => itemOnClick?.call());
    });
  }

  Widget? _wrapAnchorWidget(BuildContext context) {
    if(anchorWidget == null) {
      return null;
    }
    return GestureDetector(
      key: keyIcon,
      onTap: () => _onClickWidget(context),
      child: anchorWidget,
    );
  }

  Future<bool?> show(BuildContext context, Offset anchor) async {
    // UI尺寸，整个气泡框的宽度
    double bubbleWidth = 140.w;
    // content左边距
    double bubblePaddingLeft = 15.w;
    // 实际内容宽度
    double contentWidth = bubbleWidth - bubblePaddingLeft;
    // 气泡框距离屏幕右侧的距离
    double bubbleMarginRight = 6.w;
    // 气泡框实际相对整个屏幕的x偏移距离
    double bubbleDx = ScreenUtil().screenWidth - bubbleMarginRight - bubbleWidth;
    // 气泡框实际相对整个屏幕的y偏移距离
    double bubbleDy = anchor.dy;
    double arrowWidth = 13.w;
    double arrowHeight = 8.w;
    // 箭头的底边中心点相对于气泡框中心点的x偏移距离
    double arrowOffsetBubbleCenter = anchor.dx - bubbleDx - bubbleWidth / 2;
    return showDialog<bool>(
        context: context,
        useSafeArea: false,// RenderBox获取到的位置是包括状态栏高度的，由于状态栏的高度在这里不便获取，直接不使用SafeArea即可
        barrierColor: Colors.transparent,
        builder: (context) {
          return Stack(
              children: [
                Positioned(
                  left: bubbleDx,
                  top: bubbleDy,
                  child: ChatBubble(
                      direction: ArrowDirection.top,
                      arrowWidth: arrowWidth,
                      arrowHeight: arrowHeight,
                      padding: EdgeInsets.only(left: bubblePaddingLeft),
                      arrowBasisOffset: arrowOffsetBubbleCenter,
                      borderRadius: Radius.circular(4.w),
                      backgroundColor: Color(0xff333333),
                      child: ConstrainedBox(
                        // 限制自适应最大高度
                        constraints: BoxConstraints(minHeight: 50.h, maxHeight: 500.h, minWidth: contentWidth, maxWidth: contentWidth),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: createMenuItems(),
                          ),
                        ),
                      )
                  ),
                )
              ],
          );

    });
  }
  
  List<Widget> createMenuItems() {
    List<Widget> list = [];
    if(menus != null) {
      for(int i = 0; i < menus!.length; i ++) {
        list.add(menuItem(menus![i], i > 0));
      }
    }
    return list;
  }

  Widget menuItem(PosMenuItem item, bool withDivider) {
    return Column(
      children: [
        if(withDivider)
          Divider(height: 1.h, thickness: 1.h, color: Color(0xff444444),),
        GestureDetector(
          onTap: () {
            itemOnClick = item.onClick;
            item.itemOnClicksync?.apply((value) => value.call());
            MyNavigator().closePage();
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 15.h, 15.w, 15.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Offstage(
                  offstage: item.icon == null,
                  child: item.icon,
                ),
                Expanded(child: Text16(item.name, color: Colors.white,),)
              ],
            ),
          ),
        ),
      ],
    );
  }

}