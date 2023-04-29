import 'package:flutter/material.dart';

import '../presentation/home/home.dart';

abstract class RoutingHandler {
  static final initial = _RoutingPaths().initial;
  static final all = <String, Widget Function(BuildContext context)>{
    initial: (context) => const HomeView(),
  };
}

class _RoutingPaths {
  static _RoutingPaths _instance = _RoutingPaths._();

  final initial = '/';
  _RoutingPaths._();

  factory _RoutingPaths() {
    return _instance;
  }
}
