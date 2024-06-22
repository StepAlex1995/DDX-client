import 'package:ddx_trainer/theme/theme.dart';
import 'package:flutter/material.dart';

import 'router/app_router.dart';

class DdxApp extends StatelessWidget {
  const DdxApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'DDX Trainer',
      theme: darkAppThem,
      routes: routes,
      initialRoute: '/',
      //home: MainPage(),
    );
  }
}
