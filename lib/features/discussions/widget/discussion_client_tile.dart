import 'package:ddx_trainer/features/msg/messenger_page.dart';
import 'package:ddx_trainer/repository/msg/model/discussion_client_response.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repository/user_repository/model/user_response.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_util.dart';

class DiscussionClientTile extends StatelessWidget {
  final User user;
  final Discussion discussionClient;

  const DiscussionClientTile(
      {super.key, required this.user, required this.discussionClient});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Builder(
            builder: (context) {
              switch (discussionClient.task.exercise.difficulty) {
                case 2:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      star(theme),
                      star(theme),
                      star(theme),
                    ],
                  );
                case 1:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      star(theme),
                      star(theme),
                    ],
                  );
                case 0:
                default:
                  return star(theme);
              }
            },
          ),
        ),
        title: Text(
          discussionClient.task.exercise.title,
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: Text(
          DateUtil.convertDate(discussionClient.taskDate, 'dd MMM yyyy'),
          // discussionClient.taskDate.toString(),
          style: theme.textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        onTap: () {
          AppRouter.goToPage(
              context,
              MessengerPage(
                  user: user,
                  client: user.convertToClient(),
                  task: discussionClient.task));
        });
  }

  Widget star(ThemeData theme) {
    return const Icon(
      size: 15,
      Icons.grade_outlined,
      color: AppColor.primaryColor,
    );
  }
}
