import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'ddx_app.dart';
import 'di/di.dart';

void main() {
  Dio dio = Dio();
  dio.options.sendTimeout = const Duration(seconds: 10);
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  //dio.options.baseUrl = Config.server;

  Di.initDi(dio);

  runApp(const DdxApp());
}
