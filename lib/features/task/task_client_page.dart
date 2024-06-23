import 'package:ddx_trainer/features/feedback_file/feedback_file_page.dart';
import 'package:ddx_trainer/features/feedback_file/load_feedback_file_page.dart';
import 'package:ddx_trainer/features/msg/messenger_page.dart';
import 'package:ddx_trainer/features/task/widgets/task_param_client_widget.dart';
import 'package:ddx_trainer/repository/task/model/feedback_param.dart';
import 'package:ddx_trainer/repository/task/model/update_task_request.dart';
import 'package:ddx_trainer/repository/user_repository/model/base_model.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../repository/client/model/client.dart';
import '../../repository/task/abstract_task_repository.dart';
import '../../repository/task/model/task_model.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../exercise_list/widgets/exercise_tile.dart';
import '../widgets/rounded_button.dart';
import 'bloc/task_bloc.dart';

class TaskClientPage extends StatefulWidget {
  final User user;
  final Client client;
  final TaskModel task;

  const TaskClientPage(
      {super.key,
      required this.user,
      required this.client,
      required this.task});

  @override
  State<TaskClientPage> createState() => _TaskClientPageState();
}

class _TaskClientPageState extends State<TaskClientPage> {
  int _difficulty = 1;

  final _taskListBloc = TaskBloc(GetIt.I<AbstractTaskRepository>());

  final TextEditingController timeMinController = TextEditingController();
  final TextEditingController timeMaxController = TextEditingController();
  final TextEditingController setController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timeMinController.dispose();
    timeMaxController.dispose();
    setController.dispose();
    repeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
      child: ListView(
        children: [
          const SizedBox(height: 10),
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

          ///your results
          const SizedBox(height: 16),
          Builder(builder: (context) {
            if (isShowResultDescription()) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      AppTxt.yourResults,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Text(
                      AppTxt.target,
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
          TaskParamClientWidget(
            task: widget.task,
            paramName: TaskModel.PARAM_SET_COUNT,
            controller: setController,
          ),
          TaskParamClientWidget(
            task: widget.task,
            paramName: TaskModel.PARAM_REPEAT_COUNT,
            controller: repeatController,
          ),
          TaskParamClientWidget(
            task: widget.task,
            paramName: TaskModel.PARAM_TIME_MIN,
            controller: timeMinController,
          ),
          TaskParamClientWidget(
            task: widget.task,
            paramName: TaskModel.PARAM_TIME_MAX,
            controller: timeMaxController,
          ),
          const SizedBox(height: 16),

          Builder(builder: (context) {
            if (isUncheckedParams()) {
              return BlocListener<TaskBloc, TaskState>(
                bloc: _taskListBloc,
                listener: (context, state) {
                  if (state is TaskFeedbackParamsSend) {
                    resetParams();
                  }
                },
                child: BlocBuilder<TaskBloc, TaskState>(
                  bloc: _taskListBloc,
                  builder: (context, state) {
                    if (state is TaskFeedbackParamsSending) {
                      return const Column(
                        children: [
                          SizedBox(height: 10),
                          Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          ),
                          SizedBox(height: 14),
                        ],
                      );
                    } else if (state is TaskFeedbackParamsFailure) {
                      return Column(
                        children: [
                          Text(
                            state.msg,
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 36.0),
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: RoundedButton(
                        bgrColor: AppColor.primaryColor,
                        text: AppTxt.sendResultClient,
                        textStyle: theme.textTheme.labelMedium,
                        onPressed: () {
                          sendResultsClient();
                        },
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          }),

          const SizedBox(height: 16),
          Builder(builder: (context) {
            if (widget.task.feedbackClient >= 1) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 28.0, left: 20, right: 20),
                    child: Text(
                      AppTxt.difficultyClientCompleteForClient +
                          widget.task.feedbackClient.toString(),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color:
                              getColorByGradeClient(widget.task.feedbackClient),
                          fontSize: 20),
                    ),
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
                      widget.task.feedbackClient = _difficulty;
                      widget.task.state = 2;
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
                          SizedBox(height: 52),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 36.0),
                            child: RoundedButton(
                              bgrColor: AppColor.semiWhite,
                              text: AppTxt.tryAgain,
                              textStyle: theme.textTheme.labelMedium,
                              onPressed: () {
                                _taskListBloc.add(TaskInitEvent());
                              },
                            ),
                          ),
                          const SizedBox(height: 36),
                        ],
                      );
                    }
                    return Column(
                      children: <Widget>[
                        NumberPicker(
                          axis: Axis.horizontal,
                          value: _difficulty,
                          minValue: 1,
                          maxValue: 5,
                          onChanged: (value) =>
                              setState(() => _difficulty = value),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 36.0, right: 36, bottom: 36),
                          child: RoundedButton(
                            bgrColor: AppColor.secondaryAccentColor,
                            text: AppTxt.difficultyClient +
                                _difficulty.toString(),
                            textStyle: theme.textTheme.labelMedium,
                            onPressed: () {
                              updateTaskParam();
                              // createTask();
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
          Builder(builder: (context) {
            if (widget.task.feedbackTrainer > 0) {
              return Column(
                children: [
                  const SizedBox(height: 28),
                  Text(
                    AppTxt.gradeTrainerCompleteForClient +
                        widget.task.feedbackTrainer.toString(),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color:
                            getColorByGradeTrainer(widget.task.feedbackTrainer),
                        fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            } else {
              return Container();
            }
          }),
          Builder(builder: (context) {
            var textBtn = (widget.task.fileFeedbackUrl.isNotEmpty &&
                    widget.task.fileFeedbackUrl != BaseModel.NO_DATA_STR)
                ? AppTxt.showFeedbackFileClient
                : AppTxt.loadFeedbackFileClient;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: RoundedButton(
                bgrColor: AppColor.secondaryAccentColor,
                text: textBtn,
                textStyle: theme.textTheme.labelMedium,
                onPressed: () {
                  if (widget.task.fileFeedbackUrl.isNotEmpty &&
                      widget.task.fileFeedbackUrl != BaseModel.NO_DATA_STR) {
                    goToFeedbackFilePage();
                  } else {
                    goToLoadFeedbackFile();
                  }
                },
              ),
            );
          }),

          ///
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
      ),
    );
  }

  goToFeedbackFilePage() {
    AppRouter.goToPage(
        context,
        FeedbackFilePage(
          user: widget.user,
          fileUrl: widget.task.fileFeedbackUrl,
        ));
  }

  goToLoadFeedbackFile() {
    AppRouter.goToPage(
        context,
        LoadFeedbackFilePage(
          user: widget.user,
          task: widget.task,
        ));
  }

  goToMessenger() {
    AppRouter.goToPage(
        context,
        MessengerPage(
          user: widget.user,
          client: widget.client,
          task: widget.task,
          showTask: false,
        ));
  }

  updateTaskParam() {
    var updateTask = UpdateTaskRequest(
        feedbackClient: _difficulty,
        feedbackTrainer: widget.task.feedbackTrainer,
        state: 2,
        fileFeedbackUrl: widget.task.fileFeedbackUrl);
    _taskListBloc.add(SendFeedbackTask(
        user: widget.user,
        updateTaskRequest: updateTask,
        taskId: widget.task.id));
  }

  bool isShowResultDescription() {
    if (widget.task.params == null) {
      return false;
    }
    if (widget.task.params!.isEmpty) {
      return false;
    }
    if (widget.task.params!.length == 1 &&
        widget.task.params![0].paramName == TaskModel.PARAM_WEIGHT) {
      return false;
    }
    return true;
  }

  bool isUncheckedParams() {
    if (widget.task.params == null) {
      return false;
    }
    for (int i = 0; i < widget.task.params!.length; i++) {
      if (widget.task.params![i].value <= 0 &&
          widget.task.params![i].paramName != TaskModel.PARAM_WEIGHT) {
        return true;
      }
    }
    return false;
  }

  sendResultsClient() {
    List<FeedbackParam> params = [];
    var countParams = widget.task.params?.length ?? 0;
    if (widget.task.params != null) {
      for (var p in widget.task.params!) {
        switch (p.paramName) {
          case TaskModel.PARAM_SET_COUNT:
            if (setController.value.text.isNotEmpty) {
              params.add(FeedbackParam(
                  id: p.id, value: int.parse(setController.value.text)));
            }
            break;
          case TaskModel.PARAM_REPEAT_COUNT:
            if (repeatController.value.text.isNotEmpty) {
              params.add(FeedbackParam(
                  id: p.id, value: int.parse(repeatController.value.text)));
            }
            break;
          case TaskModel.PARAM_TIME_MIN:
            if (timeMinController.value.text.isNotEmpty) {
              params.add(FeedbackParam(
                  id: p.id, value: int.parse(timeMinController.value.text)));
            }
            break;
          case TaskModel.PARAM_TIME_MAX:
            if (timeMaxController.value.text.isNotEmpty) {
              params.add(FeedbackParam(
                  id: p.id, value: int.parse(timeMaxController.value.text)));
            }
            break;
          default:
            countParams -= 1;
        }
      }
    }
    var updateTask = UpdateTaskRequest(
        feedbackClient: widget.task.feedbackClient,
        feedbackTrainer: widget.task.feedbackTrainer,
        state: 2,
        fileFeedbackUrl: widget.task.fileFeedbackUrl,
        params: params);

    _taskListBloc.add(SendFeedbackWithParamsTask(
        user: widget.user,
        updateTaskRequest: updateTask,
        taskId: widget.task.id,
        isAllParamsSelected: countParams == params.length));
  }

  MaterialColor getColorByGradeClient(int grade) {
    if (grade >= 4) {
      return AppColor.badGrade;
    }
    if (grade <= 2) {
      return AppColor.goodGrade;
    }
    return AppColor.okGrade;
  }

  MaterialColor getColorByGradeTrainer(int grade) {
    if (grade >= 4) {
      return AppColor.goodGrade;
    }
    if (grade <= 2) {
      return AppColor.badGrade;
    }
    return AppColor.okGrade;
  }

  resetParams() {
    widget.task.state = 2;
    setState(() {
      //widget.task.feedbackClient = -1;
      for (var p in widget.task.params!) {
        switch (p.paramName) {
          case TaskModel.PARAM_SET_COUNT:
            if (setController.value.text.isNotEmpty) {
              p.value = int.parse(setController.value.text);
            }
            break;
          case TaskModel.PARAM_REPEAT_COUNT:
            if (repeatController.value.text.isNotEmpty) {
              p.value = int.parse(repeatController.value.text);
            }
            break;
          case TaskModel.PARAM_TIME_MIN:
            if (timeMinController.value.text.isNotEmpty) {
              p.value = int.parse(timeMinController.value.text);
            }
            break;
          case TaskModel.PARAM_TIME_MAX:
            if (timeMaxController.value.text.isNotEmpty) {
              p.value = int.parse(timeMaxController.value.text);
            }
            break;
        }
      }
    });
  }
}
