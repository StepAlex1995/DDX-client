import 'package:ddx_trainer/features/exercise/create_exercise_page.dart';
import 'package:ddx_trainer/features/exercise_list/bloc/exercise_list_bloc.dart';
import 'package:ddx_trainer/features/exercise/exercise_page.dart';
import 'package:ddx_trainer/features/exercise_list/widgets/exercise_list_widget.dart';
import 'package:ddx_trainer/repository/exercise/abstract_exercise_repository.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:ddx_trainer/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../repository/exercise/model/exercise.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../widgets/rounded_button.dart';

class ExerciseListPage extends StatefulWidget {
  const ExerciseListPage({super.key, required this.user});

  final User user;

  @override
  State<ExerciseListPage> createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  int groupValue = 0;
  final _exerciseListBloc =
      ExerciseListBloc(GetIt.I<AbstractExerciseRepository>());

  @override
  void initState() {
    super.initState();
    loadExerciseList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Text(
                AppTxt.tabExercises,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoSegmentedControl<int>(
                    selectedColor: theme.cardColor,
                    unselectedColor: theme.canvasColor,
                    borderColor: AppColor.semiWhite,
                    pressedColor: AppColor.semiWhite,
                    padding: const EdgeInsets.all(10),
                    groupValue: groupValue,
                    children: {
                      0: buildSegment(AppTxt.segmentPrivate, theme),
                      1: buildSegment(AppTxt.segmentPublic, theme),
                    },
                    onValueChanged: (groupValue) {
                      setState(() {
                        this.groupValue = groupValue;
                        _exerciseListBloc.add(LoadExerciseListEvent(
                            user: widget.user, isPublicExerciseList: groupValue == 1));
                      });
                    }),
              ),
              ExerciseListWidget(
                user: widget.user,
                exerciseListBloc: _exerciseListBloc,
                actionRepeat: loadExerciseList,
              ),

              /////////////////////////////////////////////////
            ],
          ),
          /////////
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: RoundedButton(
                bgrColor: theme.primaryColor,
                text: AppTxt.btnCreateExercise,
                textStyle: theme.textTheme.labelMedium,
                onPressed: () {
                  goToCreateExercise();
                  //logout(context);
                },
              ),
            ),
          ),
          /////
        ]));
  }

  goToExercise(Exercise exercise) {
    AppRouter.goToPage(context, ExercisePage(user: widget.user, exercise: exercise));
  }

  goToCreateExercise() {
    AppRouter.goToPage(
        context, CreateExercisePage(user: widget.user), false, loadExerciseList());
  }

  loadExerciseList() {
    _exerciseListBloc.add(LoadExerciseListEvent(
        user: widget.user, isPublicExerciseList: groupValue == 1));
  }

  Widget buildSegment(String text, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
            color: theme.secondaryHeaderColor,
            fontSize: 16,
            decoration: TextDecoration.none),
      ),
    );
  }
}
