import 'package:ddx_trainer/repository/client/model/client.dart';
import 'package:flutter/material.dart';

import '../../../repository/msg/model/discussion_client_response.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../router/app_router.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_util.dart';
import '../../msg/messenger_page.dart';

class DiscussionTrainerTail extends StatelessWidget {
  final User user;
  final Discussion discussion;

  const DiscussionTrainerTail(
      {super.key, required this.user, required this.discussion});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Builder(
            builder: (context) {
              if (discussion.client.isMan) {
                return const Icon(
                  Icons.male,
                  size: 30,
                  color: AppColor.primaryColor,
                );
              } else {
                return const Icon(
                  Icons.female,
                  size: 30,
                  color: AppColor.secondaryAccentColor,
                );
              }
            },
          ),
        ),
        title: Text(
          discussion.client.name,
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: Text(
          '[${DateUtil.convertDate(discussion.task.date, 'dd MMM yyyy')}]\t\t${discussion.task.exercise.title}',
          style: theme.textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        onTap: () {
          AppRouter.goToPage(
              context,
              MessengerPage(
                user: user,
                client: Client(
                    id: discussion.client.id,
                    name: discussion.client.name,
                    isMan: discussion.client.isMan,
                    phone: discussion.client.phone,
                    birthDate: discussion.client.birthDate),
                task: discussion.task,
                showTask: true,
              ));
        });
  }
}
