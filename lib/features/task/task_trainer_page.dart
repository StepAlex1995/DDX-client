import 'package:ddx_trainer/features/task/widgets/task_param_result_widget.dart';
import 'package:ddx_trainer/repository/client/model/client.dart';
import 'package:ddx_trainer/repository/task/model/task_model.dart';
import 'package:ddx_trainer/repository/task/model/update_task_request.dart';
import 'package:ddx_trainer/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../repository/task/abstract_task_repository.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../router/app_router.dart';
import '../../text/text.dart';
import '../exercise_list/widgets/exercise_tile.dart';
import '../msg/messenger_page.dart';
import '../widgets/rounded_button.dart';
import 'bloc/task_bloc.dart';

class TaskTrainerPage extends StatefulWidget {
  final User user;
  final Client client;
  final TaskModel task;

  const TaskTrainerPage(
      {super.key,
      required this.user,
      required this.client,
      required this.task});

  @override
  State<TaskTrainerPage> createState() => _TaskTrainerPageState();
}

class _TaskTrainerPageState extends State<TaskTrainerPage> {
  int _grade = 5;

  final _taskListBloc = TaskBloc(GetIt.I<AbstractTaskRepository>());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
        child: ListView(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          AppTxt.titleTask,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge,
        ),
        Material(
          child:
              ExerciseTile(exercise: widget.task.exercise, user: widget.user),
        ),

        ///description
        Builder(builder: (context) {
          if (widget.task.description.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    AppTxt.description,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    widget.task.description,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }
          return Container();
        }),

        ///weight
        Builder(builder: (context) {
          var param = widget.task.getParamByName(TaskModel.PARAM_WEIGHT);
          if (param != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    AppTxt.weight,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    param.target.toString() + AppTxt.kg,
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
        TaskParamResultWidget(
          task: widget.task,
          paramName: TaskModel.PARAM_SET_COUNT,
        ),
        TaskParamResultWidget(
          task: widget.task,
          paramName: TaskModel.PARAM_REPEAT_COUNT,
        ),
        TaskParamResultWidget(
          task: widget.task,
          paramName: TaskModel.PARAM_TIME_MIN,
        ),
        TaskParamResultWidget(
          task: widget.task,
          paramName: TaskModel.PARAM_TIME_MAX,
        ),
        //Builder(builder: (context) {}),
        Builder(builder: (context) {
          if (widget.task.state < 2) {
            return Container();
          }
          if (widget.task.feedbackTrainer >= 1) {
            return Column(
              children: [
                const SizedBox(height: 28),
                Text(
                  AppTxt.gradeTrainerCompleteForTrainer +
                      widget.task.feedbackTrainer.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: AppColor.secondaryAccentColor),
                ),
                const SizedBox(height: 24),
              ],
            );
          } else {
            return BlocListener<TaskBloc, TaskState>(
              bloc: _taskListBloc,
              listener: (context, state) {
                if (state is TaskFeedbackTrainerSend) {
                  setState(() {
                    widget.task.feedbackTrainer = _grade;
                  });
                }
              },
              child: BlocBuilder<TaskBloc, TaskState>(
                bloc: _taskListBloc,
                builder: (context, state) {
                  if (state is TaskFeedbackTrainerSending) {
                    return const Column(
                      children: [
                        SizedBox(height: 58),
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    );
                  } else if (state is TaskFeedbackTrainerFailure) {
                    return Column(
                      children: [
                        const SizedBox(height: 18),
                        Text(
                          state.msg,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36.0),
                          child: RoundedButton(
                            bgrColor: AppColor.semiWhite,
                            text: AppTxt.tryAgain,
                            textStyle: theme.textTheme.labelMedium,
                            onPressed: () {
                              _taskListBloc.add(TaskInitEvent());
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: <Widget>[
                      NumberPicker(
                        axis: Axis.horizontal,
                        value: _grade,
                        minValue: 1,
                        maxValue: 5,
                        onChanged: (value) => setState(() => _grade = value),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 36.0),
                        child: RoundedButton(
                          bgrColor: AppColor.secondaryAccentColor,
                          text: AppTxt.gradeTrainer + _grade.toString(),
                          textStyle: theme.textTheme.labelMedium,
                          onPressed: () {
                            updateTaskParam();
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }
        }),

        ///
        Builder(builder: (context) {
          if (widget.task.feedbackClient > 0) {
            return Column(
              children: [
                const SizedBox(height: 28),
                Text(
                  AppTxt.difficultyClientCompleteForTrainer +
                      widget.task.feedbackClient.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: AppColor.secondaryAccentColor),
                ),
                const SizedBox(height: 24),
              ],
            );
          } else {
            return Container();
          }
        }),
        /////
        Padding(
          padding: const EdgeInsets.all(36.0),
          child: RoundedButton(
            bgrColor: AppColor.semiWhite,
            text: AppTxt.goToMsg,
            textStyle: theme.textTheme.labelMedium,
            onPressed: () {
              goToMessenger();
            },
          ),
        ),
      ],
    ));
  }

  goToMessenger() {
    AppRouter.goToPage(
        context,
        MessengerPage(
          user: widget.user,
          client: widget.client,
          task: widget.task,
        ));
  }

  updateTaskParam() {
    var updateTask = UpdateTaskRequest(
        feedbackClient: widget.task.feedbackClient,
        feedbackTrainer: _grade,
        state: 3,
        fileFeedbackUrl: widget.task.fileFeedbackUrl);
    _taskListBloc.add(SendFeedbackTask(
        user: widget.user,
        updateTaskRequest: updateTask,
        // UpdateTaskRequest(feedbackTrainer: _grade),
        taskId: widget.task.id));
  }
}
