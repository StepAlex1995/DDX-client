import 'package:ddx_trainer/features/task_list/task_list_page.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repository/client/model/client.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../widgets/rounded_button.dart';

class ClientPage extends StatelessWidget {
  final User user;
  final Client client;

  const ClientPage({super.key, required this.user, required this.client});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    String dateText = formatter.format(client.birthDate);

    return CupertinoPageScaffold(
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            client.name,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            textAlign: TextAlign.center,
            client.phone,
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            AppTxt.phone,
            style: theme.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          //
          const SizedBox(
            height: 30,
          ),
          Text(
            textAlign: TextAlign.center,
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
            textAlign: TextAlign.center,
            client.isMan ? AppTxt.male_s : AppTxt.female_s,
            style: theme.textTheme.bodyMedium,
          ),
          Text(
            AppTxt.sex,
            style: theme.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 150,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 54.0),
                child: RoundedButton(
                  bgrColor: theme.colorScheme.onSecondary,
                  text: AppTxt.btnShowState,
                  textStyle: theme.textTheme.labelMedium,
                  onPressed: () {
                    //goToEditProfile(context);
                  },
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 54.0),
                child: RoundedButton(
                  bgrColor: theme.primaryColor,
                  text: AppTxt.btnShowTask,
                  textStyle: theme.textTheme.labelMedium,
                  onPressed: () {
                    goToTaskListPage(context);
                  },
                ),
              ),
              const SizedBox(
                height: 72,
              ),
            ],
          ),
          ////
        ],
      ),
    );
  }

  goToTaskListPage(BuildContext context) {
    AppRouter.goToPage(context, TaskListPage(user: user, client: client));
  }
}
