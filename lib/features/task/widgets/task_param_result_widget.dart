import 'package:ddx_trainer/repository/task/model/task_model.dart';
import 'package:flutter/material.dart';

import '../../../text/text.dart';

class TaskParamResultWidget extends StatelessWidget {
  final TaskModel task;
  final String paramName;

  const TaskParamResultWidget(
      {super.key, required this.task, required this.paramName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Builder(builder: (context) {
      var param = task.getParamByName(paramName);
      if (param != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    paramName,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      AppTxt.target,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    param.value.toString() + getPostfix(param.value),
                    textAlign: TextAlign.end,
                    style: theme.textTheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      param.target.toString() + getPostfix(param.target),
                      textAlign: TextAlign.end,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }

  String getPostfix(int value) {
    if (paramName == TaskModel.PARAM_SET_COUNT ||
        paramName == TaskModel.PARAM_REPEAT_COUNT) {
      if (value % 10 >= 2 &&
          value % 10 <= 4 &&
          (value % 100 < 10 || value % 100 > 20)) {
        return AppTxt.count1;
      } else {
        return AppTxt.count;
      }
    } else {
      return AppTxt.sec;
    }
  }
}
