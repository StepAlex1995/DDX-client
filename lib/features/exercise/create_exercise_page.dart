import 'package:ddx_trainer/features/exercise/bloc/exercise_bloc.dart';
import 'package:ddx_trainer/features/load_photo_exercise/load_photo_exercise.dart';
import 'package:ddx_trainer/repository/exercise/abstract_exercise_repository.dart';
import 'package:ddx_trainer/repository/exercise/model/add_exercise_request.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/exercise/model/exercise.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../widgets/rounded_button.dart';
import '../widgets/text_input.dart';

class CreateExercisePage extends StatefulWidget {
  final User user;
  Exercise? exercise;

  CreateExercisePage({super.key, required this.user, this.exercise});

  @override
  State<CreateExercisePage> createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  void onChangeTextInput(String txt) {
    //_editProfileBloc.add(EditProfileInitEvent());
    _exerciseBloc.add(ExerciseInitEvent());
  }

  String emptyDataDropdown = AppTxt.emptyDataDropdown;
  String muscleValue = AppTxt.emptyDataDropdown;
  String typeValue = AppTxt.emptyDataDropdown;
  String equipmentValue = AppTxt.emptyDataDropdown;
  String difficultyValue = AppTxt.emptyDataDropdown;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final _exerciseBloc = ExerciseBloc(GetIt.I<AbstractExerciseRepository>());

  @override
  void initState() {
    super.initState();
    _exerciseBloc.add(ExerciseInitEvent());
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
        child: Container(
      decoration: BoxDecoration(color: theme.canvasColor),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              const SizedBox(height: 20),
              textDescription(AppTxt.descriptionTitle, theme),
              TextInput(
                maxLines: 2,
                onChange: (text) {
                  onChangeTextInput(text);
                },
                controller: titleController,
                //icon: CupertinoIcons.waveform_path_ecg,
                hint: "",
                // AppTxt.descriptionTitleExample,
                inputType: TextInputType.name,
                inputAction: TextInputAction.next,
                isPassword: false,
              ),

              /////
              const SizedBox(height: 20),
              textDescription(AppTxt.descriptionMuscle, theme),
              dropdown(
                context,
                AppTxt.musculeDropdownItems,
                (newValue) => {
                  setState(() {
                    muscleValue = newValue!;
                    _exerciseBloc.add(ExerciseInitEvent());
                  })
                },
              ),
              /////
              const SizedBox(height: 20),
              textDescription(AppTxt.descriptionType, theme),
              dropdown(
                context,
                AppTxt.typeDropdownItems,
                (newValue) => {
                  setState(() {
                    typeValue = newValue!;
                    _exerciseBloc.add(ExerciseInitEvent());
                  })
                },
              ),
              /////
              const SizedBox(height: 20),
              textDescription(AppTxt.descriptionEquipment, theme),
              dropdown(
                context,
                AppTxt.equipmentDropdownItems,
                (newValue) => {
                  setState(() {
                    equipmentValue = newValue!;
                    _exerciseBloc.add(ExerciseInitEvent());
                  })
                },
              ),
              const SizedBox(height: 20),
              textDescription(AppTxt.descriptionDifficulty, theme),
              dropdown(
                context,
                AppTxt.difficultyDropdownItems,
                (newValue) => {
                  setState(() {
                    difficultyValue = newValue!;
                    _exerciseBloc.add(ExerciseInitEvent());
                  })
                },
              ),
              //
              const SizedBox(height: 20),
              textDescription(AppTxt.descriptionAdditionalInfo, theme),
              TextInput(
                maxLines: 2,
                onChange: (text) {
                  onChangeTextInput(text);
                },
                controller: descriptionController,
                // icon: CupertinoIcons.info_circle_fill,
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
                    goToLoadPhotoExercise(state.exerciseId);
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
                            padding:
                                const EdgeInsets.only(left: 36.0, right: 36),
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
                            //goToCreateExercise(context);
                            //showConfirmAddExerciseDialog(context, exercise);
                          },
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  goToLoadPhotoExercise(int exerciseId) {
    AppRouter.goToPage(
        context, LoadPhotoExercise(user: widget.user, exerciseId: exerciseId));
  }

  uploadExercise() {
    _exerciseBloc.add(UploadExerciseEvent(
        user: widget.user,
        exerciseRequest: AddExerciseRequest(
            title: titleController.value.text,
            muscle: muscleValue,
            type: typeValue,
            equipment: equipmentValue,
            difficulty: difficultyValue == AppTxt.lvlHard
                ? 2
                : difficultyValue == AppTxt.lvlMedium
                    ? 1
                    : difficultyValue == AppTxt.lvlEasy
                        ? 0
                        : -1,
            isPublic: false,
            description: descriptionController.value.text,
            state: 1)));
  }

  Widget textDescription(String textDesc, ThemeData theme) => Center(
        child: Text(
          textDesc,
          style: theme.textTheme.titleSmall,
        ),
      );

  Widget dropdown(BuildContext context, List<DropdownMenuItem<String>> items,
      Function(String?) onChange) {
    final theme = Theme.of(context);

    return Material(
      child: DropdownButtonFormField(
        style: theme.textTheme.labelSmall,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.appGrey, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.appGrey, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: AppColor.appGrey,
        ),
        focusColor: AppColor.appGrey,
        borderRadius: BorderRadius.circular(20),
        dropdownColor: AppColor.appGrey,
        value: emptyDataDropdown,
        onChanged: onChange,
        items: items,
      ),
    );
  }
}
