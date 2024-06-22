import 'package:ddx_trainer/features/auth/login_page.dart';
import 'package:ddx_trainer/features/edit_profile/edit_profile_page.dart';
import 'package:ddx_trainer/features/home_client/home_client_page.dart';
import 'package:ddx_trainer/features/home_trainer/home_trainer_page.dart';
import 'package:ddx_trainer/repository/user_repository/abstract_user_repository.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../repository/user_repository/model/user_response.dart';
import '../widgets/bgr_img.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  checkUser() async {
    User? user = await GetIt.I<AbstractUserRepository>().getSavedUser();
    if (!mounted) return;
    Widget page = const LoginPage();
    if (user == null) {
      page = const LoginPage();
    } else {
      if (user.role == User.TRAINER_ROLE) {
        page = HomeTrainerPage(
          user: user,
          indexTab: 0,
        );
      } else {
        if (user.role == User.CLIENT_ROLE) {
          if (user.isFullProfile ?? false) {
            page = HomeClientPage(user: user);
          } else {
            page = EditProfilePage(user: user);
          }
        } else {
          page = const LoginPage();
        }
      }
    }
    AppRouter.goToPage(context, page, true);
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: BgrImg(
        assetImg: AssetImage('assets/img/bgr_auth1.jpg'),
      ),
    );
  }
}
