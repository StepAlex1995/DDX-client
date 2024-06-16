import 'package:ddx_trainer/features/widgets/bgr_img.dart';
import 'package:ddx_trainer/features/widgets/text_input.dart';
import 'package:ddx_trainer/features/registration/bloc/registration_bloc.dart';
import 'package:ddx_trainer/repository/user_repository/abstract_user_repository.dart';
import 'package:ddx_trainer/repository/user_repository/model/reg_user.dart';
import 'package:ddx_trainer/text/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../router/app_router.dart';
import '../edit_profile/edit_profile_page.dart';
import '../home_client/home_client_page.dart';
import '../widgets/rounded_button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _registrationBloc = RegistrationBloc(GetIt.I<AbstractUserRepository>());
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _registrationBloc.add(RegistrationInitEvent());
  }

  void onChangeTextInput(String txt) {
    _registrationBloc.add(RegistrationInitEvent());
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
        child: Stack(
      children: [
        const BgrImg(
          assetImg: AssetImage('assets/img/bgr_auth2.jpg'),
        ),
        Container(
          //backgroundColor: Colors.transparent,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: SafeArea(
            child: ListView(
              children: [
                SizedBox(
                  height: 180,
                  child: Center(
                    child: Text(
                      AppTxt.registrationTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
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
                              const SizedBox(
                                height: 80,
                              ),
                              TextInput(
                                onChange: (text) {
                                  onChangeTextInput(text);
                                },
                                icon: Icons.person,
                                hint: AppTxt.login,
                                inputType: TextInputType.emailAddress,
                                controller: loginController,
                                inputAction: TextInputAction.next,
                                isPassword: false,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextInput(
                                onChange: (text) {
                                  onChangeTextInput(text);
                                },
                                icon: Icons.lock,
                                hint: AppTxt.password,
                                inputType: TextInputType.emailAddress,
                                controller: passwordController,
                                inputAction: TextInputAction.next,
                                isPassword: true,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextInput(
                                onChange: (text) {
                                  onChangeTextInput(text);
                                },
                                controller: passwordRepeatController,
                                icon: Icons.lock,
                                hint: AppTxt.passwordRepeat,
                                inputType: TextInputType.emailAddress,
                                inputAction: TextInputAction.done,
                                isPassword: true,
                              ),
                              BlocListener<RegistrationBloc, RegistrationState>(
                                bloc: _registrationBloc,
                                listener: (context, state) {
                                  if (state is RegistrationSuccessState) {
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
                                },
                                child: BlocBuilder<RegistrationBloc,
                                    RegistrationState>(
                                  bloc: _registrationBloc,
                                  builder: (context, state) {
                                    if (state is RegistrationErrorState) {
                                      return Column(
                                        children: [
                                          const SizedBox(height: 54),
                                          Text(
                                            state.msg,
                                            style: theme.textTheme.bodySmall,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          RoundedButton(
                                            onPressed: () {
                                              registration();
                                            },
                                            bgrColor: theme.primaryColor,
                                            textStyle:
                                                theme.textTheme.labelMedium,
                                            text: AppTxt.btnCreateAccount,
                                          )
                                        ],
                                      );
                                    } else if (state
                                        is RegistrationProgressState) {
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 95),
                                          child: CircularProgressIndicator(
                                              color: theme.primaryColor),
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 80),
                                        child: RoundedButton(
                                          onPressed: () {
                                            registration();
                                          },
                                          bgrColor: theme.primaryColor,
                                          textStyle:
                                              theme.textTheme.labelMedium,
                                          text: AppTxt.btnCreateAccount,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  registration() {
    _registrationBloc.add(RegistrationUserEvent(
        regUser: RegUser(
      login: loginController.text,
      password: passwordController.text,
      passwordRepeat: passwordRepeatController.text,
    )));
  }
}
