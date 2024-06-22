import 'package:ddx_trainer/repository/exercise/model/exercise.dart';
import 'package:ddx_trainer/theme/theme.dart';
import 'package:flutter/material.dart';

import '../../../repository/user_repository/model/user_response.dart';
import '../../../router/app_router.dart';
import '../../exercise/exercise_page.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final User user;
  final Function(Exercise)? getExercise;

  const ExerciseTile(
      {super.key,
      required this.exercise,
      required this.user,
      this.getExercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Builder(
            builder: (context) {
              switch (exercise.difficulty) {
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
          exercise.title,
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: Text(
          exercise.muscle,
          style: theme.textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColor.semiWhite,
        ),
        onTap: () {
          if (getExercise != null) {
            getExercise!(exercise);
          } else {
            AppRouter.goToPage(
                context, ExercisePage(user: user, exercise: exercise));
          }
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
