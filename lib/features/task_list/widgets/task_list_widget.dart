import 'package:ddx_trainer/features/task_list/bloc/task_list_bloc.dart';
import 'package:ddx_trainer/features/task_list/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/task/model/task_model.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';
import '../../../theme/theme.dart';
import '../../exercise_list/widgets/error_info.dart';

class TaskListWidget extends StatefulWidget {
  final User user;
  final TaskListBloc _taskListBloc;
  final Function() actionRepeat;
  final Function(TaskModel) getTask;

  const TaskListWidget(
      {super.key,
      required this.user,
      required TaskListBloc taskListBloc,
      required this.actionRepeat,
      required this.getTask})
      : _taskListBloc = taskListBloc;

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TaskListBloc, TaskListState>(
        bloc: widget._taskListBloc,
        builder: (context, state) {
          if (state is TaskListLoaded) {
            return Material(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, i) {
                  return TaskTile(
                    task: state.taskList[i],
                    user: widget.user,
                    getTask: widget.getTask,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(color: theme.dividerColor);
                },
                itemCount: state.taskList.length,
              ),
            );
          } else if (state is TaskListFailure) {
            return Column(
              children: [
                const SizedBox(height: 200),
                ErrorInfo(
                  textTitle: state.code == 200 ? state.msg : null,
                  textDescription: AppTxt.taskListEmptyDescription,
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
