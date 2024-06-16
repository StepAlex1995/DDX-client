import 'package:ddx_trainer/features/exercise_list/exercise_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:badges/badges.dart' as badges;

import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../client_list/client_list_page.dart';
import '../discussions/discussions_page.dart';
import '../profile/profile_page.dart';

class HomeTrainerPage extends StatefulWidget {
  const HomeTrainerPage(
      {super.key, required this.user, required this.indexTab});

  final User user;
  final int indexTab;

  @override
  State<HomeTrainerPage> createState() =>
      _HomeTrainerPageState(user: user, indexTab: indexTab);
}

class _HomeTrainerPageState extends State<HomeTrainerPage> {
  final User user;

  _HomeTrainerPageState({required this.user, required this.indexTab});

  int currentIndex = 0;
  final int indexTab;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentIndex = indexTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: theme.cardColor,
          activeColor: theme.primaryColor,
          iconSize: 24,
          currentIndex: currentIndex,
          items: [
            const BottomNavigationBarItem(
                label: AppTxt.tabClients,
                icon: Icon(
                  CupertinoIcons.person_2_alt,
                )),
            const BottomNavigationBarItem(
                label: AppTxt.tabExercises,
                icon: Icon(
                  CupertinoIcons.waveform_path_ecg,
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
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return ClientListPage(user: user);
            case 1:
              return ExerciseListPage(user: user);
            case 2:
              return DiscussionsPage(user: user);
            case 3:
              return ProfilePage(user: widget.user);
            default:
              return ClientListPage(user: user);
          }
        });
  }
}
