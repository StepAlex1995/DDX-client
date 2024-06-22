import 'package:ddx_trainer/di/di.dart';
import 'package:ddx_trainer/features/statistics/statistics_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../discussions/discussions_page.dart';
import '../profile/profile_page.dart';
import '../task_list/task_list_page.dart';

class HomeClientPage extends StatefulWidget {
  const HomeClientPage({super.key, required this.user});

  final User user;

  @override
  State<HomeClientPage> createState() => _HomeClientPageState();
}

class _HomeClientPageState extends State<HomeClientPage> {
  /*void _onTap(int value) {
    print('Value => $value');
    if (value == 2) {
      myHomeState.initState();
    }
    indexPrevValue = value;
  }*/

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            backgroundColor: theme.cardColor,
            activeColor: theme.primaryColor,
            iconSize: 24,
            items: [
              const BottomNavigationBarItem(
                  label: AppTxt.tabTasks,
                  icon: Icon(
                    CupertinoIcons.waveform_path_ecg,
                  )),
              const BottomNavigationBarItem(
                  label: AppTxt.tabState,
                  icon: Icon(
                    CupertinoIcons.chart_bar_fill,
                  )),
              BottomNavigationBarItem(
                  label: AppTxt.tabDiscussions,
                  icon: badges.Badge(
                      showBadge: false,
                      badgeContent: Text(
                        '1',
                        style: theme.textTheme.bodyMedium,
                      ),
                      child: const Icon(CupertinoIcons.quote_bubble_fill))),
              const BottomNavigationBarItem(
                  label: AppTxt.tabProfile,
                  icon: Icon(
                    CupertinoIcons.person_fill,
                  )),
            ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return TaskListPage(
                  user: widget.user, client: widget.user.convertToClient());
            case 1:
              return const StatisticsPage();
            case 2:
              return DiscussionsPage(user: widget.user);
            case 3:
              return ProfilePage(user: widget.user);
            default:
              return ProfilePage(user: widget.user);
          }
        });
  }
}
