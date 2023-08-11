
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyColor {
  static const main_bg = Color(0xffDFE9EA);
  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
  static const actionbar_bg = main_green;
  static const main_grey = Color(0xfff5f5f5);
  static const actionbar_icon = Colors.white;
  static const transparent = Color(0xffffff);
  static const text_normal = Color(0xff333333);
  static const text_second = Color(0xff666666);
  static const text_sub = Color(0xff999999);
  static const edit_bg = Color(0xffF2F2F2);
  static const divider = Color(0xffeeeeee);
  static const divider_ddd = Color(0xffdddddd);
  static const cccColor = Color(0xffcccccc);
  static const eeeColor = Color(0xffeeeeee);
  static const textbutton_bg = Color(0x33d9d9d9);
  static const ripple_color = Color(0x33000000);
  static const bg_tag_bbb = Color(0xffBBBBBB);
  static const text_btn_login = Color(0xff204447);
  static const main_green = Color(0xff1BABB9);
  static const main_alpha_green = Color(0x111babb9);
  static const main_red = Color(0xffF53F3F);
  static const website_color = Color(0xff1BABB9);
  static const main_green_alph = Color(0x1a1babb9);
  static const containerBg = Color(0xfff5f7f7);
  static const bubbleBg = Color(0xfffd7d23);
  static const tagBg = Color(0xfffd9528);
  static const redText = Color(0xfff53f3f);
  static const text_grey_f5f7f9 = Color(0xffF5F7F9);
  static const f5bg = Color(0xfff5f5f5);
  static const lightBlueBg = Color(0xfff0fafb);
  static const remarkBg = Color(0xffFFE5D3);
  static const percent10Red = Color(0x1AF53F3F);
  static const shadowBg = Color(0x36707070);
  static const throughText = Color(0xffcccccc);
  static const tag_concat = Color(0xffe0b585);
  static const billBg = Color(0x1a14b0cc);
  static const borderLine = Color(0xffDDDDDD);
  static const no_serve = Color(0xffFFB875);
  static const serveWayNameNormal = Color(0xff3A76FF);
  static const serveWayNameUrgency = Color(0xffF53F3F);
  static const saveItemOrder = Color(0xffDDAD78);
  static const edit = Color(0xff3E8AB9);
  static const kbBg = Color(0xffE8E9ED);
  static const kbSwitchBg = Color(0xffCACACA);
  static const kbShadow = Color(0xff898A8D);


  static const table_status_empty = Color(0xff417A13);
  static const table_status_occupy = Color(0xffE42718);
  static const table_status_md = Color(0xff6D167D);
  static const table_status_clear = Color(0xff9D9D9D);
  static const table_status_booked = Color(0xff3d5fcb);
  static const table_status_lock = Color(0xff3C3C3C);

  static const table_status_bg = Color(0xffa7aec4);

  //pos text
  static const pos_text_green = Color(0xff1fc48b);
  static const pos_text_yellow = Color(0xfffec62e);
  static const pos_text_blue = Color(0xff42b2f0);

  static const text_orange = Color(0xffFF7D00);

  static const tag_time_price = Color(0xfff3ba2d);
  static const tag_promote = Color(0xffed41dd);
  static const tag_limit = Color(0xfffc1923);
  static const tag_zxj_zhao = Color(0xfffd9528);
  static const tag_zxj_xin = Color(0xff21c589);
  static const tag_zxj_jian = Color(0xfffc6227);
  static const tag_pkg_normal = Color(0xff28c9e5);
  static const tag_pkg_yh = Color(0xff398bfb);
  static const tag_vip = Color(0xfff2de34);
  static const tag_vip_text = Color(0xff2b2b2b);

  static const method_tab_bg = Color(0xffd1eef1);

  static const slide_menu_bg = Color(0xffcccccc);
  static const slide_menu_highlight = Color(0xFFFFA500);
  static const slide_menu_text = Color(0xFF666666);

  static const bill_green = Color(0xFF24B383);
  static const bill_yellow = Color(0xFFFD7D23);
  static const bill_grey = Color(0xFF999999);

  static const coupon_bg_yellow = Color(0xffffB403);
  static const coupon_bg_blue = Color(0xfff4DB4DF);

  static const tag_method_bg = Color(0xffFFF1D8);
  static const tag_serve_way_bg = Color(0xffD8EDFF);
  static const tag_serve_way_text = Color(0xff1D618C);

  static const loading = Color(0xFF4cbdc8);
  static const green_deep = Color(0xFF28828A);

  static const reserve_confirm = Color(0xFFDDAD78);

  static Color hexColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if(hexColor.length == 6) {
      hexColor = 'ff$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}

class MyDimen {

  static final MyDimen _instance = MyDimen._internal();

  factory MyDimen() {
    return _instance;
  }

  MyDimen._internal();

  double text_18 = 18.w;
  double text_normal = 16.w;
  double text_second = 14.w;
  double text_small = 12.w;

  double actionbar_height = 45.h;// actionbar自身高度

  double shop_bar_height = 58.h;// 加单页汇总栏高度
  double big_class_height = 38.w;// 大类列表高度
  double small_class_height = 40.h;// 小类统一高度

  double dialog_title_height = 60.h;
  double list_divider_height = 1.h;

  double item_min_height = 75.h;// 菜品列表里的菜品最小高度
  double concat_tag_width = 3.w;// 拼菜的蓝色标签宽度
  double class_of_itemlist_height = 30.h;// 菜品列表里的菜品类别高度
  double simple_item_min_height = 132.h;// 简约点菜菜品列表里的菜品最小高度
}