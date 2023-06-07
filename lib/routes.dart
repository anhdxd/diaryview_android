import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/detail.dart';

class Routes {
  static final FluroRouter router = FluroRouter();

  static void configureRoutes() {
    router.define(
      '/detail/:item',
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
          final item = params['item']?[0];
          return Detail(item: item);
        },
      ),
    );
  }
}
