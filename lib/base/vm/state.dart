
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../base_page.dart';
import '../lifecycle/lifecycle_aware.dart';
import '../lifecycle/lifecycle_mixin.dart';
import '../../utils/log.dart';
import 'base_viewmodel.dart';




/// 监听声明周期的base state
abstract class LifeState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver, BasePage, LifecycleAware, LifecycleMixin {

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    printExt("[$this]$event");
    switch(event) {
      case LifecycleEvent.active:
        onResume();
        break;
      case LifecycleEvent.visible:
        onStart();
        break;
      case LifecycleEvent.inactive:
        onPause();
        break;
      case LifecycleEvent.invisible:
        onStop();
        break;
      default: break;
    }
  }

  void onStart() {
    printExt("[$this]onStart");
  }

  void onResume() {
    printExt("[$this]onResume");
  }

  void onPause() {
    printExt("[$this]onPause");
  }

  void onStop() {
    printExt("[$this]onStop");
  }

  @override
  void initState() {
    super.initState();
    printExt("[$this]initState");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    printExt("[$this]didChangeDependencies");
  }

  @override
  void dispose() {
    super.dispose();
    printExt("[$this]dispose");
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void deactivate() {
    super.deactivate();
    printExt("[$this]deactivate");
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    printExt("[$this]didUpdateWidget");
  }

  @override
  void didChangeAccessibilityFeatures() {
    printExt("[$this]didChangeAccessibilityFeatures");
  }

  @override
  void didHaveMemoryPressure() {
    printExt("[$this]didHaveMemoryPressure");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    printExt("[$this]didChangeAppLifecycleState $state");
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    printExt("[$this]didChangeLocales");
  }

  @override
  void didChangePlatformBrightness() {
    printExt("[$this]didChangePlatformBrightness");
  }

  @override
  void didChangeTextScaleFactor() {
    printExt("[$this]didChangeTextScaleFactor");
  }

  @override
  void didChangeMetrics() {
    printExt("[$this]didChangeMetrics");
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    printExt("[$this]didPushRouteInformation");
    return super.didPushRouteInformation(routeInformation);
  }

  @override
  Future<bool> didPushRoute(String route) {
    printExt("[$this]didPushRoute");
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    printExt("[$this]didPopRoute");
    return super.didPopRoute();
  }
}

/// 集成viewModel
abstract class ViewModelState<T extends StatefulWidget, VM extends BaseViewModel> extends LifeState<T> {

  late VM viewModel;

  T? getArguments<T>(BuildContext context) {

    /* if(ModalRoute.of(context)?.settings.arguments!=null){
      return ModalRoute.of(context)?.settings.arguments as T;
    }*/
    if(Get.arguments!=null){
      return Get.arguments as T;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    viewModel = createViewModel();
    viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  VM createViewModel();

}