import 'package:ddx_trainer/repository/exercise/model/exercise.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';
import '../../../theme/theme.dart';
import '../bloc/exercise_list_bloc.dart';
import 'error_info.dart';
import 'exercise_tile.dart';

class ExerciseListWidget extends StatefulWidget {
  final User user;
  final ExerciseListBloc exerciseListBloc;
  final Function() actionRepeat;
  final Function(Exercise)? getExercise;

  const ExerciseListWidget(
      {super.key,
      required this.user,
      required this.exerciseListBloc,
      required this.actionRepeat,
      this.getExercise});

  @override
  State<ExerciseListWidget> createState() => _ExerciseListWidgetState(
      user: user,
      exerciseListBloc: exerciseListBloc,
      actionRepeat,
      getExercise);
}

class _ExerciseListWidgetState extends State<ExerciseListWidget> {
  final User user;
  final ExerciseListBloc _exerciseListBloc;
  final Function() actionRepeat;
  final Function(Exercise)? getExercise;

  _ExerciseListWidgetState(this.actionRepeat, this.getExercise,
      {required this.user, required ExerciseListBloc exerciseListBloc})
      : _exerciseListBloc = exerciseListBloc;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ExerciseListBloc, ExerciseListState>(
        bloc: _exerciseListBloc,
        builder: (context, state) {
          if (state is ExerciseListLoaded) {
            return Expanded(
                child: Material(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, i) {
                  return ExerciseTile(
                    exercise: state.exerciseList[i],
                    user: user,
                    getExercise: getExercise,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: theme.dividerColor,
                  );
                },
                itemCount: state.exerciseList.length,
              ),
            ));
          } else if (state is ExerciseListFailure) {
            return Column(
              children: [
                const SizedBox(height: 250),
                ErrorInfo(
                  /*btnAction: () {
                    state.code == 200
                        ? null
                        : actionRepeat(); //loadExerciseList();
                  },*/
                  textTitle: state.code == 200 ? state.msg : null,
                  textDescription: state.code == 200
                      ? AppTxt.exerciseListEmptyDescription
                      : null,
                ),
              ],
            );
          } else {
            return const Column(
              children: [
                SizedBox(height: 300),
                Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            );
          }
        });
  }
}
