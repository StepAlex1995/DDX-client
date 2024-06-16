import 'package:ddx_trainer/features/add_task/bloc/add_task_bloc.dart';
import 'package:ddx_trainer/features/add_task/exercise_list_for_task_widget.dart';
import 'package:ddx_trainer/features/exercise_list/widgets/exercise_tile.dart';
import 'package:ddx_trainer/features/task_list/task_list_page.dart';
import 'package:ddx_trainer/repository/task/abstract_task_repository.dart';
import 'package:ddx_trainer/repository/task/model/create_task_request.dart';
import 'package:ddx_trainer/repository/task/model/task_param_request.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:ddx_trainer/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../repository/client/model/client.dart';
import '../../repository/exercise/abstract_exercise_repository.dart';
import '../../repository/exercise/model/exercise.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../exercise_list/bloc/exercise_list_bloc.dart';
import '../exercise_list/widgets/exercise_list_widget.dart';
import '../widgets/rounded_button.dart';
import '../widgets/text_input.dart';

class AddTaskExercisePage extends StatefulWidget {
  final User user;
  final Client client;
  final DateTime date;

  const AddTaskExercisePage(
      {super.key,
      required this.user,
      required this.client,
      required this.date});

  @override
  State<AddTaskExercisePage> createState() =>
      _AddTaskExercisePageState(user, client, date);
}

class _AddTaskExercisePageState extends State<AddTaskExercisePage> {
  final User user;
  final Client client;
  final DateTime date;

  _AddTaskExercisePageState(this.user, this.client, this.date);

  final _exerciseListBloc =
      ExerciseListBloc(GetIt.I<AbstractExerciseRepository>());

  Exercise? selectedExercise;

  final _addTaskBloc = AddTaskBloc(GetIt.I<AbstractTaskRepository>());

  @override
  void initState() {
    super.initState();
    _exerciseListBloc
        .add(LoadExerciseListEvent(user: user, isPublicExerciseList: false));
  }

  final TextEditingController weightController = TextEditingController();
  final TextEditingController timeMinController = TextEditingController();
  final TextEditingController timeMaxController = TextEditingController();
  final TextEditingController setController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool needSendPhoto = false;

  @override
  void dispose() {
    weightController.dispose();
    timeMinController.dispose();
    timeMaxController.dispose();
    setController.dispose();
    repeatController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    String dateText = formatter.format(date);

    return CupertinoPageScaffold(
        child: ListView(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          client.name,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge,
        ),
        Text(
          dateText,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        Builder(builder: (context) {
          if (selectedExercise == null) {
            return SizedBox(
              height: 600,
              child: ExerciseListForTaskWidget(
                user: widget.user,
                exerciseListBloc: _exerciseListBloc,
                actionRepeat: repeatLoadExercise,
                getExercise: getExercise,
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                    height: 500,
                    child: ListView(
                      children: [
                        Material(
                          child: ExerciseTile(
                              exercise: selectedExercise!, user: user),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36.0),
                          child: RoundedButton(
                            bgrColor: AppColor.secondaryAccentColor,
                            text: AppTxt.btnResetExercise,
                            textStyle: theme.textTheme.labelMedium,
                            onPressed: () {
                              breakExercise();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            AppTxt.selectExerciseParams,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextInput(
                            onChange: (text) {
                              setTaskBlocInit();
                            },
                            onlyPositiveNumbers: true,
                            controller: weightController,
                            icon: Icons.line_weight,
                            hint: AppTxt.weight,
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.next,
                            isPassword: false,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextInput(
                            onChange: (text) {
                              setTaskBlocInit();
                            },
                            onlyPositiveNumbers: true,
                            controller: timeMinController,
                            icon: Icons.timer,
                            hint: AppTxt.timeMin,
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.next,
                            isPassword: false,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextInput(
                            onChange: (text) {
                              setTaskBlocInit();
                            },
                            onlyPositiveNumbers: true,
                            controller: timeMaxController,
                            icon: Icons.more_time_sharp,
                            hint: AppTxt.timeMax,
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.next,
                            isPassword: false,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextInput(
                            onChange: (text) {
                              setTaskBlocInit();
                            },
                            onlyPositiveNumbers: true,
                            controller: setController,
                            icon: Icons.repeat,
                            hint: AppTxt.setCount,
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.next,
                            isPassword: false,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextInput(
                            onChange: (text) {
                              setTaskBlocInit();
                            },
                            onlyPositiveNumbers: true,
                            controller: repeatController,
                            icon: Icons.repeat_one,
                            hint: AppTxt.repeatCount,
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.next,
                            isPassword: false,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: TextInput(
                            onChange: (text) {
                              setTaskBlocInit();
                            },
                            maxLines: 2,
                            controller: descriptionController,
                            icon: Icons.description_outlined,
                            hint: AppTxt.description,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.next,
                            isPassword: false,
                          ),
                        ),
                        //Text("exercise = $selectedExercise"),
                      ],
                    )),
                BlocListener<AddTaskBloc, AddTaskState>(
                  listener: (context, state) {
                    if (state is AddTaskUploaded) {
                      closeAddTaskPage();
                    }
                  },
                  bloc: _addTaskBloc,
                  child: BlocBuilder<AddTaskBloc, AddTaskState>(
                    bloc: _addTaskBloc,
                    builder: (context, state) {
                      if (state is AddTaskFailure) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                state.msg,
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              RoundedButton(
                                bgrColor: theme.primaryColor,
                                text: AppTxt.btnCreateTask,
                                textStyle: theme.textTheme.labelMedium,
                                onPressed: () {
                                  createTask();
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (state is AddTaskUploading) {
                        return Column(
                          children: [
                            const SizedBox(height: 50),
                            CircularProgressIndicator(
                              color: theme.primaryColor,
                            )
                          ],
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(36.0),
                        child: RoundedButton(
                          bgrColor: theme.primaryColor,
                          text: AppTxt.btnCreateTask,
                          textStyle: theme.textTheme.labelMedium,
                          onPressed: () {
                            createTask();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ],
    ));
  }

  createTask() {
    final simpleDate = DateTime(date.year, date.month, date.day);
    List<TaskParamRequest> taskParams = [];

    if (weightController.value.text.isNotEmpty) {
      var taskWeight = TaskParamRequest(
          paramName: AppTxt.weight,
          target: int.parse(weightController.value.text),
          value: 0);
      taskParams.add(taskWeight);
    }
    if (timeMinController.value.text.isNotEmpty) {
      var taskTimeMin = TaskParamRequest(
          paramName: AppTxt.timeMin,
          target: int.parse(timeMinController.value.text),
          value: 0);
      taskParams.add(taskTimeMin);
    }
    if (timeMaxController.value.text.isNotEmpty) {
      var taskTimeMax = TaskParamRequest(
          paramName: AppTxt.timeMax,
          target: int.parse(timeMaxController.value.text),
          value: 0);
      taskParams.add(taskTimeMax);
    }
    if (setController.value.text.isNotEmpty) {
      var taskSet = TaskParamRequest(
          paramName: AppTxt.setCount,
          target: int.parse(setController.value.text),
          value: 0);
      taskParams.add(taskSet);
    }
    if (repeatController.value.text.isNotEmpty) {
      var taskRepeat = TaskParamRequest(
          paramName: AppTxt.repeatCount,
          target: int.parse(repeatController.value.text),
          value: 0);
      taskParams.add(taskRepeat);
    }

    var createTaskRequest = CreateTaskRequest(
        date: simpleDate.toUtc().millisecondsSinceEpoch ~/ 1000,
        clientId: client.id,
        exerciseId: selectedExercise!.id,
        description: descriptionController.value.text,
        state: 0,
        params: taskParams);
    //print('createTaskRequest = $createTaskRequest');
    _addTaskBloc.add(
        AddTaskUploadEvent(user: user, createTaskRequest: createTaskRequest));
  }

  closeAddTaskPage() {
    Navigator.pop(context);
    Navigator.pop(context);
    AppRouter.goToPage(context, TaskListPage(user: user, client: client));
  }

  setTaskBlocInit() {
    _addTaskBloc.add(AddTaskInitEvent());
  }

  getExercise(Exercise exercise) {
    //print("exe = $exerciseId");
    setState(() {
      selectedExercise = exercise;
      setTaskBlocInit();
    });
  }

  breakExercise() {
    setState(() {
      selectedExercise = null;
    });
  }

  repeatLoadExercise() {
    _exerciseListBloc
        .add(LoadExerciseListEvent(user: user, isPublicExerciseList: false));
  }
}
