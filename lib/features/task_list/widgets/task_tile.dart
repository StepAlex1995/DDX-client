import 'package:ddx_trainer/repository/task/model/task_model.dart';
import 'package:flutter/material.dart';

import '../../../repository/user_repository/model/user_response.dart';
import '../../../theme/theme.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final User user;
  final Function(TaskModel) getTask;

  const TaskTile({
    super.key,
    required this.task,
    required this.user,
    required this.getTask,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Builder(
            builder: (context) {
              switch (task.exercise.difficulty) {
                case 2:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      star(theme, task.state),
                      star(theme, task.state),
                      star(theme, task.state),
                    ],
                  );
                case 1:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      star(theme, task.state),
                      star(theme, task.state),
                    ],
                  );
                case 0:
                default:
                  return star(theme, task.state);
              }
            },
          ),
        ),
        title: Text(
          task.exercise.title,
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: Text(
          task.exercise.muscle,
          style: theme.textTheme.labelSmall?.copyWith(fontSize: 14),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColor.semiWhite,
        ),
        onTap: () {
          getTask(task);
        });
  }

  Widget star(ThemeData theme, int taskState) {
    return Icon(
      size: 15,
      Icons.grade_outlined,
      color: taskState <= 1 ? AppColor.primaryColor : AppColor.goodGrade,
    );
  }
}
