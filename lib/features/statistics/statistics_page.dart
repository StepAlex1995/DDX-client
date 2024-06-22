import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../text/text.dart';
import '../exercise_list/widgets/error_info.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Text(
              AppTxt.tabState,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 300.0),
                child: ErrorInfo(
                  textTitle: AppTxt.inDeveloping,
                  textDescription: AppTxt.inDevelopingDescription,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
