import 'package:ddx_trainer/features/home_trainer/home_trainer_page.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/exercise/abstract_exercise_repository.dart';
import '../../repository/exercise/model/add_exercise_request.dart';
import '../../repository/exercise/model/exercise.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../widgets/rounded_button.dart';
import '../widgets/text_input.dart';
import 'bloc/exercise_bloc.dart';

class AddExercisePage extends StatefulWidget {
  final User user;
  final Exercise exercise;

  const AddExercisePage(
      {super.key, required this.user, required this.exercise});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  final TextEditingController descriptionController = TextEditingController();

  final _exerciseBloc = ExerciseBloc(GetIt.I<AbstractExerciseRepository>());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            AppTxt.titleExercise,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          textDescription(AppTxt.descriptionAdditionalInfo, theme),
          TextInput(
            maxLines: 6,
            onChange: (text) {
              onChangeTextInput(text);
            },
            controller: descriptionController,
            hint: "",
            // AppTxt.descriptionTitleExample,
            inputType: TextInputType.name,
            inputAction: TextInputAction.done,
            isPassword: false,
          ),
          BlocListener<ExerciseBloc, ExerciseState>(
            bloc: _exerciseBloc,
            listener: (context, state) {
              if (state is ExerciseUploaded) {
                //goToLoadPhotoExercise(state.exerciseId);
                AppRouter.goToPage(
                    context, HomeTrainerPage(user: widget.user, indexTab: 1));
              }
            },
            child: BlocBuilder<ExerciseBloc, ExerciseState>(
              bloc: _exerciseBloc,
              builder: (context, state) {
                if (state is ExerciseFailure) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          state.msg,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0, right: 36),
                        child: RoundedButton(
                          bgrColor: theme.primaryColor,
                          text: AppTxt.btnAdd,
                          textStyle: theme.textTheme.labelMedium,
                          onPressed: () {},
                        ),
                      )
                    ],
                  );
                } else if (state is ExerciseUploading) {
                  return Column(
                    children: [
                      const SizedBox(height: 50),
                      CircularProgressIndicator(
                        color: theme.primaryColor,
                      )
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 36.0, right: 36, top: 36, bottom: 36),
                    child: RoundedButton(
                      bgrColor: theme.primaryColor,
                      text: AppTxt.btnAdd,
                      textStyle: theme.textTheme.labelMedium,
                      onPressed: () {
                        uploadExercise();
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  uploadExercise() {
    _exerciseBloc.add(CopyExerciseEvent(
        user: widget.user,
        oldExerciseId: widget.exercise.id,
        exerciseRequest: AddExerciseRequest(
            title: widget.exercise.title,
            muscle: widget.exercise.muscle,
            type: widget.exercise.type,
            equipment: widget.exercise.equipment,
            difficulty: widget.exercise.difficulty,
            isPublic: false,
            description: descriptionController.value.text,
            state: 1)));
  }

  void onChangeTextInput(String txt) {
    //_editProfileBloc.add(EditProfileInitEvent());
    _exerciseBloc.add(ExerciseInitEvent());
  }

  Widget textDescription(String textDesc, ThemeData theme) => Center(
        child: Text(
          textDesc,
          style: theme.textTheme.titleSmall,
        ),
      );
}
