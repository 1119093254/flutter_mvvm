import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monbile_push_project/base/view/popup_menu.dart';
import 'package:monbile_push_project/base/view/widgets.dart';
import 'package:monbile_push_project/utils/extensions.dart';

import '../navigator.dart';
import '../res/menus.dart';
import '../res/resources.dart';
import '../res/styles.dart';
import '../vm/state.dart';

/// 通用actionbar，集成返回、标题、搜索框、功能按钮、更多菜单
/// 采用向状态栏整体溢出的方式，便于控制高度和距离，不采用SafeArea
/// 标题和搜索框最多只能二选一
class PosActionBar extends StatefulWidget implements PreferredSizeWidget {
  static double defaultHeight = MyDimen().actionbar_height;

  /// 高度
  double? height;

  /// 隐藏返回按钮
  bool? hideBack;

  /// 自定义返回键位置的Widget
  Widget Function(BuildContext)? customBack;

  /// 指定返回事件
  Function()? onBack;

  /// 所有右边的文字、图标按钮
  List<BasePosAction>? actions;

  /// 所有左边的文字、图标按钮（替换返回按钮的位置）
  List<BasePosAction>? leftActions;

  /// 下拉弹出菜单
  List<PosMenuItem>? popupMenu;

  /// 自定义下拉菜单依附的action按钮，固定在最右端，默认为...图标
  PosPopupMenuAnchor? popupMenuAnchor;

  /// 显示搜索栏
  bool? showSearch;

  /// 搜索框的hint
  String? searchHintText;

  /// 搜索框的hint
  FocusNode? searchFocusNode;

  /// 使用自定义键盘
  bool? useCustomSearch;

  /// 标题
  /// centerWidget为空时显示该文字
  String? title;

  /// 标题居左（在返回键之后），默认居中
  bool? titleInLeft;

  /// 自定义在左侧的标题（titleInLeft=true生效，且与铺满搜索框互斥）
  Widget? customLeftTitle;

  Function(String)? onSearchChanged;
  TextEditingController? searchController;
  Function(String)? onClickMenuItem;
  Function(PosActionBarState)? stateProvider;

  ///标题栏中间自定义widget
  ///为空是显示title
  Widget? centerWidget;

  /// 离开页面时清除输入框焦点
  bool? removeInputFocusOnStop;

  PosActionBar(
      {Key? key,
      this.searchFocusNode,
      this.height,
      this.actions,
      this.leftActions,
      this.customBack,
      this.onBack,
      this.hideBack,
      this.title,
      this.titleInLeft,
      this.customLeftTitle,
      this.centerWidget,
      this.showSearch,
      this.onSearchChanged,
      this.searchController,
      this.searchHintText,
      this.useCustomSearch,
      this.popupMenu,
      this.popupMenuAnchor,
      this.onClickMenuItem,
      this.removeInputFocusOnStop,
      this.stateProvider})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PosActionBarState();
  }

  /// 状态栏高度
  static double getStatusBarHeight() {
    return MediaQuery.of(MyNavigator().currentContext()!).padding.top;
  }

  /// 去掉SafeArea包裹后，必须指定总高度为溢出高度+实际高度
  @override
  Size get preferredSize =>
      Size.fromHeight((height ?? defaultHeight) + getStatusBarHeight());

  /// 通用默认actionbar高度
  static defaultTotalActionBarHeight(BuildContext context) {
    return defaultHeight + getStatusBarHeight();
  }
}

class PosActionBarState extends LifeState<PosActionBar> {
  bool isShowClear = false;

  @override
  void initState() {
    super.initState();
    widget.stateProvider?.call(this);
  }

  void setTitle(String name) {
    widget.title = name;
  }

  void setTitleCenter(bool ifCenter) {
    widget.titleInLeft = ifCenter;
  }

  void updateTitle(String name) {
    setState(() {
      widget.title = name;
    });
  }

  void updateCustomTitle(Widget? title) {
    setState(() {
      widget.customLeftTitle = title;
    });
  }

  void updateSearchText(String text) {
    setState(() {
      isShowClear = text.isNotEmpty;
      widget.searchController?.text = text;
    });
  }

  void updateActionsAndMenus(
      {List<BasePosAction>? actions,
      List<PosMenuItem>? popupMenu,
      PosPopupMenuAnchor? popupMenuAnchor}) {
    setState(() {
      widget.actions = actions;
      widget.popupMenu = popupMenu;
      widget.popupMenuAnchor = popupMenuAnchor;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = widget.preferredSize.height;
    // 只能用唯一Widget，如果用Column，children之间会出现无法去除的白色分割线
    return Container(
      height: totalHeight,
      padding: EdgeInsets.only(top: PosActionBar.getStatusBarHeight()),
      color: MyColor.actionbar_bg,
      child: SizedBox(
        height: widget.height ?? PosActionBar.defaultHeight,
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    if (widget.titleInLeft == true) {
      return _mainRow(context, isLeftTitle: true);
    } else {
      return Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _mainRow(context),
          ),
        ],
      );
    }
  }

  Widget _mainRow(BuildContext context, {bool? isLeftTitle}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: createWidgets(context, isLeftTitle: isLeftTitle),
    );
  }

  List<Widget> createWidgets(BuildContext context, {bool? isLeftTitle}) {
    List<Widget> list = [];
    // 返回按钮与左侧actions只能存在其一
    if (widget.leftActions == null) {
      if (widget.hideBack == true) {
        list.add(MarginHor(15.w));
      } else {
        // back
        list.add(widget.customBack?.call(context) ??
            IconButton(
              iconSize: 17.w,
              onPressed: widget.onBack ?? (() => MyNavigator().closePage()),
              icon: Center(
                child: Image.asset(
                  'assets/img/ic_arrows_left.png',
                  color: MyColor.white,
                ),
              ),
              alignment: Alignment.center,
              splashRadius: 20.w,
              padding: EdgeInsets.all(11.w),
            ));
      }
    } else {
      // 自定义左侧action
      widget.leftActions?.forEach((element) {
        if (element is PosTextAction) {
          if (element.withBorder == true) {
            list.add(Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: roundTextAction(element),
            ));
          } else {
            list.add(Padding(
              padding: EdgeInsets.only(left: 7.w),
              child: textAction(element),
            ));
          }
        } else if (element is PosIconAction) {
          list.add(iconAction(element));
        }
      });
    }
    // title or search bar
    list.add(Expanded(child: expandPart(isLeftTitle: isLeftTitle)));
    // 自定义右侧action
    widget.actions?.forEach((element) {
      if (element is PosTextAction) {
        if (element.withBorder == true) {
          list.add(Padding(
            padding: EdgeInsets.only(right: 7.w),
            child: roundTextAction(element),
          ));
        } else {
          list.add(Padding(
            padding: EdgeInsets.only(right: element.rightPadding ?? 7.w),
            child: textAction(element),
          ));
        }
      } else if (element is PosIconAction) {
        list.add(iconAction(element));
      }
    });
    // 下拉弹出菜单
    widget.popupMenu?.apply((menus) {
      Widget? replaceAnchor;
      if (widget.popupMenuAnchor?.iconRes != null) {
        replaceAnchor = iconAction(PosIconAction(
          widget.popupMenuAnchor!.iconRes!,
          width: widget.popupMenuAnchor?.width,
          height: widget.popupMenuAnchor?.height,
          label: widget.popupMenuAnchor?.label,
        ));
      }
      if (widget.popupMenuAnchor?.text != null) {
        if (widget.popupMenuAnchor?.textWithBorder != null) {
          replaceAnchor = roundTextAction(PosTextAction(
              widget.popupMenuAnchor!.text!,
              withBorder: true,
              isFocus: true));
        } else {
          replaceAnchor =
              textAction(PosTextAction(widget.popupMenuAnchor!.text!));
        }
      }
      list.add(Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: PosPopupMenu(
          menus: menus,
          anchorWidget: replaceAnchor,
        ),
      ));
    });
    return list;
  }

  /// 标题和搜索框只能存在一个
  Widget expandPart({bool? isLeftTitle}) {
    if (widget.showSearch ?? false) {
      return Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w),
        child: searchInput(),
      );
    } else {
      return Container();
    }
  }

  Widget searchInput() {
    bool? _isReadOnly = widget.useCustomSearch == true;
    return Container(
      height: 35.h,
      // constraints: BoxConstraints(maxHeight: 30.h, minHeight: 30.h),
      decoration: BoxDecoration(
          color: MyColor.white, borderRadius: BorderRadius.circular(7.w)),
      child: TextField(
        focusNode: widget.searchFocusNode,
        controller: widget.searchController,
        maxLines: 1,
        readOnly: _isReadOnly,
        showCursor: true,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 14.w, color: MyColor.text_second),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 2),
            child: Image.asset('assets/img/ic_search.png'),
          ),
          prefixIconConstraints: BoxConstraints(
              minWidth: 30.w, maxWidth: 30.w, maxHeight: 18.w, minHeight: 18.w),
          suffixIcon: SizedBox(
            width: 30,
            child: Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: isShowClear,
              child: clearIcon('assets/img/ic_clear.png', () {
                setState(() {
                  isShowClear = false;
                });
                widget.searchController?.text = '';
                widget.onSearchChanged?.call('');
              }),
            ),
          ),
          hintText: widget.searchHintText,
          contentPadding: EdgeInsets.only(bottom: 0),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          // 根据源码注释，border参数只有在enabledBorder, focusedBorder都为null才生效，所以如果只设置border，系统又提供了默认的focusBorder，最后是不会生效的
          // enabledBorder: searchBorder(),
          // focusedBorder: searchBorder(),
        ),
        onChanged: (value) {
          toggleClear(value);
          widget.onSearchChanged?.call(value);
        },
      ),
    );
  }

  void toggleClear(String value) {
    bool showClear = value.isNotEmpty;
    if (showClear != isShowClear) {
      setState(() {
        isShowClear = showClear;
      });
    }
  }

  /// 图标按钮
  Widget iconAction(PosIconAction item) {
    return IconButton(
      constraints: BoxConstraints(
          minWidth: item.width ?? 36.w, minHeight: item.height ?? 36.w),
      onPressed: item.onClick,
      icon: item.ifOriginalColor == true
          ? Image.asset(
              item.iconRes,
              semanticLabel: item.label,
            )
          : Image.asset(
              item.iconRes,
              color: MyColor.actionbar_icon,
              semanticLabel: item.label,
            ),
      iconSize: 20.w,
      padding: EdgeInsets.all(item.padding ?? 8.w),
      splashRadius: 30.w,
      // splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,
    );
  }

  /// 无边框文字按钮
  Widget textAction(PosTextAction item) {
    return _wrapWithGestureOrNot(
      onTap: item.onClick,
      child: Container(
        height: widget.height,
        color: Colors.transparent,
        // 必须设置个背景色才能有效扩大选中区域
        padding: EdgeInsets.only(left: 13.w, right: 13.w),
        alignment: Alignment.centerLeft,
        child: Text15(
          item.name,
          color: MyColor.actionbar_icon,
        ),
      ),
    );
  }

  /// 圆角边框文字按钮
  Widget roundTextAction(PosTextAction item) {
    BoxDecoration decoration;
    Color textColor;
    if (item.isFocus == true) {
      decoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.w),
      );
      textColor = MyColor.main_green;
    } else {
      decoration = BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.w),
        borderRadius: BorderRadius.circular(6.w),
      );
      textColor = Colors.white;
    }
    return _wrapWithGestureOrNot(
      onTap: item.onClick,
      child: Container(
        height: 30.h,
        decoration: decoration,
        padding: EdgeInsets.only(left: 11.w, right: 11.w),
        alignment: Alignment.centerLeft,
        child: Text14(
          item.name,
          color: textColor,
        ),
      ),
    );
  }

  Widget _wrapWithGestureOrNot({required Widget child, Function()? onTap}) {
    if (onTap == null) {
      return child;
    } else {
      return GestureDetector(
        onTap: onTap,
        child: child,
      );
    }
  }

  /// 搜索框里的清除按钮
  Widget clearIcon(String name, Function() onPressed) {
    return Container(
      child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: onPressed,
        icon: Center(
          child: Image.asset(
            name,
            width: 15,
            height: 15,
          ),
        ),
        color: MyColor.eeeColor,
      ),
    );
  }

  @override
  void onStop() {
    if (widget.removeInputFocusOnStop == true) {
      FocusScope.of(context).unfocus();
    }
    super.onStop();
  }
}
