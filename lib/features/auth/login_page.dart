import 'package:ddx_trainer/features/auth/bloc/auth_bloc.dart';
import 'package:ddx_trainer/features/widgets/bgr_img.dart';
import 'package:ddx_trainer/features/widgets/text_input.dart';
import 'package:ddx_trainer/features/edit_profile/edit_profile_page.dart';
import 'package:ddx_trainer/features/home_client/home_client_page.dart';
import 'package:ddx_trainer/features/home_trainer/home_trainer_page.dart';
import 'package:ddx_trainer/features/registration/registration_page.dart';
import 'package:ddx_trainer/repository/user_repository/abstract_user_repository.dart';
import 'package:ddx_trainer/repository/user_repository/model/auth_user.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../widgets/rounded_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authBloc = AuthBloc(GetIt.I<AbstractUserRepository>());
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authBloc.add(AuthInitEvent());
  }

  void onChangeTextInput(String txt) {
    _authBloc.add(AuthInitEvent());
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          const BgrImg(
            assetImg: AssetImage('assets/img/bgr_auth1.jpg'),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            //backgroundColor: Colors.transparent,
            child: SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: 180,
                    child: Center(
                      child: Text(
                        AppTxt.appName,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextInput(
                                  onChange: (text) {
                                    onChangeTextInput(text);
                                  },
                                  controller: loginController,
                                  icon: Icons.person,
                                  hint: AppTxt.login,
                                  inputType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next,
                                  isPassword: false,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: TextInput(
                                    onChange: (text) {
                                      onChangeTextInput(text);
                                    },
                                    controller: passwordController,
                                    icon: Icons.lock,
                                    hint: AppTxt.password,
                                    inputType: TextInputType.emailAddress,
                                    inputAction: TextInputAction.done,
                                    isPassword: true,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                BlocListener<AuthBloc, AuthState>(
                                  bloc: _authBloc,
                                  listener: (context, state) {
                                    if (state is AuthSuccessState) {
                                      if (state.user.role ==
                                          User.TRAINER_ROLE) {
                                        AppRouter.goToPage(
                                            context,
                                            HomeTrainerPage(
                                              user: state.user,
                                              indexTab: 0,
                                            ),
                                            true);
                                      } else {
                                        if (state.user.isFullProfile == true) {
                                          AppRouter.goToPage(
                                              context,
                                              HomeClientPage(user: state.user),
                                              true);
                                        } else {
                                          AppRouter.goToPage(
                                              context,
                                              EditProfilePage(user: state.user),
                                              true);
                                        }
                                      }
                                    }
                                  },
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                    bloc: _authBloc,
                                    builder: (context, state) {
                                      if (state is AuthProgressState) {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 94,
                                            ),
                                            CircularProgressIndicator(
                                              color: theme.primaryColor,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        );
                                      } else if (state is AuthErrorState) {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 54,
                                            ),
                                            Text(
                                              state.msg,
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            RoundedButton(
                                              bgrColor: theme.primaryColor,
                                              textStyle:
                                                  theme.textTheme.labelMedium,
                                              text: AppTxt.btnLogin,
                                              onPressed: () {
                                                _authBloc.add(AuthUserEvent(
                                                    authUser: AuthUser(
                                                        login: loginController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text)));
                                              },
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: [
                                            const SizedBox(
                                              height: 80,
                                            ),
                                            RoundedButton(
                                              bgrColor: theme.primaryColor,
                                              textStyle:
                                                  theme.textTheme.labelMedium,
                                              text: AppTxt.btnLogin,
                                              onPressed: () {
                                                authorization();
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 120,
                                ),
                                CupertinoButton(
                                    child: Text(
                                      AppTxt.btnRegistration,
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    onPressed: () {
                                      goToRegistrationPage();
                                    })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  authorization() {
    _authBloc.add(AuthUserEvent(
        authUser: AuthUser(
      login: loginController.text,
      password: passwordController.text,
    )));
  }

  goToRegistrationPage() {
    AppRouter.goToPage(context, const RegistrationPage());
  }
}
