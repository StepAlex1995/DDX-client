import 'package:flutter/material.dart';
import '../../../repository/task/model/task_model.dart';
import '../../../text/text.dart';
import '../../widgets/text_input.dart';

class TaskParamClientWidget extends StatelessWidget {
  final TaskModel task;
  final String paramName;
  final TextEditingController controller;

  const TaskParamClientWidget({
    super.key,
    required this.task,
    required this.paramName,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(builder: (context) {
      var param = task.getParamByName(paramName);
      if (param != null) {
        if (param.value > 0) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
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
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  textDirection: TextDirection.ltr,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        param.value.toString() + getPostfix(param.value),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        param.target.toString() + getPostfix(param.target),
                        textAlign: TextAlign.right,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextInput(
                      onChange: (text) {},
                      controller: controller,
                      icon: getIcon(),
                      hint: paramName,
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.done,
                      isPassword: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    param.target.toString() + getPostfix(param.target),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }
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

  IconData? getIcon() {
    switch (paramName) {
      case TaskModel.PARAM_SET_COUNT:
        return Icons.repeat;
      case TaskModel.PARAM_REPEAT_COUNT:
        return Icons.repeat_one;
      case TaskModel.PARAM_TIME_MIN:
        return Icons.timer;
      case TaskModel.PARAM_TIME_MAX:
        return Icons.more_time_sharp;
    }
    return null;
  }
}
