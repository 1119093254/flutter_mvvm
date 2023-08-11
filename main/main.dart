import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:monbile_push_project/base/lifecycle/lifecycle_observer.dart';
import 'package:monbile_push_project/base/res/resources.dart';
import 'package:monbile_push_project/generated/l10n.dart';
import 'package:monbile_push_project/utils/packages.dart';

import 'page/main_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  // 捕获异步异常
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const MyApp());
    },
    (Object error, StackTrace stackTrace) async {
      catchError('asynchrounous', error, stackTrace);
    },
  );

  // 捕获同步异常
  FlutterError.onError = (FlutterErrorDetails errorDetails) {
    catchError('synchronous', errorDetails.exception, errorDetails.stack);
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyPackageInfo.init();
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) => GetMaterialApp(
        // 废弃掉，自定义的路由管理
        // navigatorKey: MyNavigator().navGK,
        // 国际化i10n
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        // 生命周期
        navigatorObservers: [defaultLifecycleObserver],
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
            unselectedWidgetColor: MyColor.bg_tag_bbb),
        // easyloading
        builder: EasyLoading.init(),
        home: MainPagePage(),
      ),
    );
  }
}
