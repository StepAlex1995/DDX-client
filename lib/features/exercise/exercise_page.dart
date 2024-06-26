import 'package:ddx_trainer/features/exercise/add_exercise_page.dart';
import 'package:ddx_trainer/features/widgets/rounded_button.dart';
import 'package:ddx_trainer/features/widgets/server_image.dart';
import 'package:ddx_trainer/repository/exercise/model/photo_exercise.dart';
import 'package:ddx_trainer/repository/user_repository/model/base_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../repository/exercise/model/exercise.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../router/app_router.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key, required this.user, required this.exercise});

  final User user;
  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
        child: Container(
      decoration: BoxDecoration(color: theme.canvasColor),
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            AppTxt.titleExercise,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              exercise.title,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          //////
          SizedBox(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: exercise.photo == null ? 0 : exercise.photo!.length,
              itemBuilder: (context, idx) => buildPhoto(exercise.photo![idx],
                  idx == 0, idx == exercise.photo!.length),
            ),
          ),
          textDescription(AppTxt.descriptionMuscle, theme),
          textInfo(exercise.muscle, theme),
          const SizedBox(height: 10),

          textDescription(AppTxt.descriptionType, theme),
          textInfo(exercise.type, theme),
          const SizedBox(height: 10),

          textDescription(AppTxt.descriptionEquipment, theme),
          textInfo(exercise.equipment, theme),
          const SizedBox(height: 10),

          textDescription(AppTxt.descriptionDifficulty, theme),
          textInfo(
              exercise.difficulty == 2
                  ? AppTxt.lvlHard
                  : exercise.difficulty == 1
                      ? AppTxt.lvlMedium
                      : AppTxt.lvlEasy,
              theme),
          const SizedBox(height: 10),

          Builder(builder: (context) {
            if (exercise.description.isNotEmpty &&
                exercise.description != BaseModel.NO_DATA_STR) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textDescription(AppTxt.descriptionAdditionalInfo, theme),
                    textInfo(exercise.description, theme),
                  ]);
            } else {
              return const SizedBox(
                height: 0,
              );
            }
          }),

          Builder(builder: (context) {
            if (exercise.isPublic) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 36.0, right: 36, top: 36, bottom: 36),
                child: RoundedButton(
                  bgrColor: theme.primaryColor,
                  text: AppTxt.btnAddExercise,
                  textStyle: theme.textTheme.labelMedium,
                  onPressed: () {
                    goToAddExercisePage(context);
                    //showConfirmAddExerciseDialog(context, exercise);
                  },
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    ));
  }

  Widget textInfo(String textInf, ThemeData theme) => Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(
          textInf,
          textAlign: TextAlign.left,
          style: theme.textTheme.bodyMedium,
        ),
      );

  Widget textDescription(String textDesc, ThemeData theme) => Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Text(
          textDesc,
          textAlign: TextAlign.left,
          style: theme.textTheme.titleSmall,
        ),
      );

  Widget buildPhoto(PhotoExercise photo, bool isFirst, bool isLast) => Padding(
        padding: EdgeInsets.only(
          left: isFirst ? 16 : 8,
          right: isLast ? 16 : 8,
          top: 16,
        ),
        child: Container(
          color: AppColor.backgroundColor,
          child: Column(
            children: [
              ServerImage(
                height: 300,
                filename: photo.url,
                token: user.token,
              )
            ],
          ),
        ),
      );

  goToAddExercisePage(BuildContext context) {
    AppRouter.goToPage(
      context,
      AddExercisePage(user: user, exercise: exercise),
    );
  }
}
