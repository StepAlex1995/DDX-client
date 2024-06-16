import 'package:ddx_trainer/features/auth/login_page.dart';
import 'package:ddx_trainer/features/registration/registration_page.dart';
import 'package:ddx_trainer/features/home_trainer/home_trainer_page.dart';
import 'package:flutter/cupertino.dart';

import '../features/edit_profile/edit_profile_page.dart';
import '../features/home_client/home_client_page.dart';
import '../features/main/main_page.dart';
import '../repository/user_repository/model/user_response.dart';

final routes = {
  '/': (context) => const MainPage(),
  '/registration': (context) => const RegistrationPage(),
  '/login': (context) => const LoginPage(),
  '/home_client': (context) => HomeClientPage(user: User.createClear()),
  '/home_trainer': (context) => HomeTrainerPage(
        user: User.createClear(),
        indexTab: 0,
      ),
  '/edit_profile': (context) => EditProfilePage(user: User.createClear())
};

class AppRouter {
  static goToPage(BuildContext ctx, Widget page,
      [bool isClearStack = false, Function()? action]) {
    Navigator.pushAndRemoveUntil(
      ctx,
      CupertinoPageRoute(builder: (context) => page),
      (r) => !isClearStack,
    ).then((_) {
      setState() {
        if (action != null) {
          action;
        }
      }
    });
  }
}
