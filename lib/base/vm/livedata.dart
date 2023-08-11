
import 'package:flutter/material.dart';

import '../../utils/log.dart';

/// 模仿android livedata的简单实现（没有与生命周期绑定），仅用于ViewModel与View之间的交互
class SimpleLiveData<T> {

  List<Observer<T>> observers = [];

  observe(State state, Observer<T> observer, {String? paramName}) {
    printExt('observe $paramName ${state.toStringShort()}');
    if(!observers.contains(observer)) {
      observers.add(observer);
    }
    printExt('observe $paramName observers.length=${observers.length}');
  }

  observeWithoutState(Observer<T> observer) {
    if(!observers.contains(observer)) {
      observers.add(observer);
    }
  }

  setValue(T value) {
    printExt('observe setValue observers.length=${observers.length}');
    observers.forEach((element) { element.call(value); });
  }
}

typedef Observer<T> = void Function(T value);
