import 'package:ddx_trainer/repository/exercise/model/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';
import '../../../theme/theme.dart';
import '../exercise_list/bloc/exercise_list_bloc.dart';
import '../exercise_list/widgets/error_info.dart';
import '../exercise_list/widgets/exercise_tile.dart';

class ExerciseListForTaskWidget extends StatefulWidget {
  final User user;
  final ExerciseListBloc exerciseListBloc;
  final Function() actionRepeat;
  final Function(Exercise)? getExercise;

  const ExerciseListForTaskWidget(
      {super.key,
        required this.user,
        required this.exerciseListBloc,
        required this.actionRepeat,
        this.getExercise});

  @override
  State<ExerciseListForTaskWidget> createState() => _ExerciseListWidgetState();
}

class _ExerciseListWidgetState extends State<ExerciseListForTaskWidget> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ExerciseListBloc, ExerciseListState>(
        bloc: widget.exerciseListBloc,
        builder: (context, state) {
          if (state is ExerciseListLoaded) {
            return Material(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, i) {
                  return ExerciseTile(
                    exercise: state.exerciseList[i],
                    user: widget.user,
                    getExercise: widget.getExercise,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: theme.dividerColor,
                  );
                },
                itemCount: state.exerciseList.length,
              ),
            );
          } else if (state is ExerciseListFailure) {
            return Column(
              children: [
                const SizedBox(height: 250),
                ErrorInfo(
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
