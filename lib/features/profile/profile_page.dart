import 'package:ddx_trainer/features/auth/login_page.dart';
import 'package:ddx_trainer/features/widgets/server_image.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../repository/user_repository/abstract_user_repository.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';

import '../edit_profile/edit_profile_page.dart';
import '../widgets/rounded_button.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime dateTime = DateTime.parse(widget.user.birthDate);
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    String dateText = formatter.format(dateTime);

    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              AppTxt.tabProfile,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            Builder(builder: (context) {
              if (widget.user.role == User.TRAINER_ROLE &&
                  widget.user.photoUrl.isNotEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    ServerImage(
                      filename: widget.user.photoUrl,
                      token: widget.user.token,
                      width: 250,
                      height: 150,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Container(),
                  ],
                );
              }
            }),
            Text(
              widget.user.name,
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              AppTxt.name,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.user.phone,
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              AppTxt.phone,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              dateText,
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              AppTxt.birthdate,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.user.isMan ? AppTxt.male_s : AppTxt.female_s,
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              AppTxt.sex,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            Builder(
              builder: (context) {
                if (widget.user.role == User.CLIENT_ROLE) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 36,
                      ),
                      RoundedButton(
                        bgrColor: theme.colorScheme.onSecondary,
                        text: AppTxt.btnGoToEditProfile,
                        textStyle: theme.textTheme.labelMedium,
                        onPressed: () {
                          goToEditProfile(context);
                        },
                      ),
                      //SizedBox(height: 24)
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            Expanded(
                child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: RoundedButton(
                  bgrColor: theme.primaryColor,
                  text: AppTxt.btnLogout,
                  textStyle: theme.textTheme.labelMedium,
                  onPressed: () {
                    logout(context);
                  },
                ),
              ),
            ))
          ]),
        ),
      ),
    );
  }

  logout(BuildContext context) async {
    await GetIt.I<AbstractUserRepository>().logout();
    if (context.mounted) {
      AppRouter.goToPage(context, const LoginPage(), true);
    }
  }

  goToEditProfile(BuildContext context) async {
    AppRouter.goToPage(context, EditProfilePage(user: widget.user));
  }
}
