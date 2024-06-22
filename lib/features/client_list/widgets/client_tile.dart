import 'package:ddx_trainer/features/client/client_page.dart';
import 'package:flutter/material.dart';

import '../../../repository/client/model/client.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../router/app_router.dart';
import '../../../theme/theme.dart';

class ClientTile extends StatelessWidget {
  final User user;
  final Client client;

  const ClientTile({super.key, required this.user, required this.client});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Builder(
            builder: (context) {
              if (client.isMan) {
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
          client.name,
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: Text(
          client.phone,
          style: theme.textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColor.semiWhite,
        ),
        onTap: () {
          AppRouter.goToPage(context, ClientPage(user: user, client: client));
        });
  }
}
