import 'package:ddx_trainer/features/add_task/add_task_exercise_page.dart';
import 'package:ddx_trainer/features/task/task_client_page.dart';
import 'package:ddx_trainer/features/task/task_trainer_page.dart';
import 'package:ddx_trainer/features/task_list/bloc/task_list_bloc.dart';
import 'package:ddx_trainer/features/task_list/widgets/task_list_widget.dart';
import 'package:ddx_trainer/repository/task/abstract_task_repository.dart';
import 'package:ddx_trainer/repository/task/model/task_list_request.dart';
import 'package:ddx_trainer/repository/task/model/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../repository/client/model/client.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../router/app_router.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../widgets/rounded_button.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key, required this.user, required this.client});

  final User user;
  final Client client;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final _taskListBloc = TaskListBloc(GetIt.I<AbstractTaskRepository>());

  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    setState(() {
      selectedDay = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      getTaskList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Text(
            AppTxt.tabTasks,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          Material(
            child: TableCalendar(
              calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  holidayDecoration: BoxDecoration(
                    color: AppColor.transparentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  weekendDecoration: BoxDecoration(
                    color: AppColor.transparentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  todayDecoration: BoxDecoration(
                    color: AppColor.darkBackgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  defaultDecoration: BoxDecoration(
                    color: AppColor.transparentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  selectedTextStyle:
                      const TextStyle(color: AppColor.mainTextColor)),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                formatButtonShowsNext: false,
              ),
              onDaySelected: (selectDay, focusDay) {
                setState(() {
                  selectedDay =
                      DateTime(selectDay.year, selectDay.month, selectDay.day);
                  focusedDay = focusDay;
                  getTaskList();
                });
              },
              selectedDayPredicate: (date) {
                return isSameDay(selectedDay, date);
              },
              onPageChanged: (day) {},
              daysOfWeekVisible: true,
              daysOfWeekHeight: 30,
              startingDayOfWeek: StartingDayOfWeek.monday,
              weekendDays: const [6, 7],
              onFormatChanged: (dae) {},
              calendarFormat: CalendarFormat.twoWeeks,
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2050, 3, 14),
              focusedDay: focusedDay,
            ),
          ),
          SizedBox(
            height: 450,
            child: Container(
              color: AppColor.backgroundColor,
              child: TaskListWidget(
                user: widget.user,
                taskListBloc: _taskListBloc,
                actionRepeat: getTaskList,
                getTask: selectTask,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Builder(builder: (context) {
            var currentDate = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day);
            if (widget.user.role == User.TRAINER_ROLE &&
                selectedDay.toUtc().millisecondsSinceEpoch >=
                    currentDate.toUtc().millisecondsSinceEpoch) {
              return Padding(
                  padding: const EdgeInsets.only(left: 54.0,right: 54.0,bottom: 24),
                  child: RoundedButton(
                    bgrColor: theme.primaryColor,
                    text: AppTxt.btnAddTask,
                    textStyle: theme.textTheme.labelMedium,
                    onPressed: () {
                      goToAddTaskPage(context);
                    },
                  ));
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  selectTask(TaskModel task) {
    if (widget.user.role == User.TRAINER_ROLE) {
      AppRouter.goToPage(
          context,
          TaskTrainerPage(
              user: widget.user, client: widget.client, task: task));
    } else {
      AppRouter.goToPage(context,
          TaskClientPage(user: widget.user, client: widget.client, task: task));
    }
  }

  goToAddTaskPage(BuildContext context) {
    AppRouter.goToPage(
        context,
        AddTaskExercisePage(
          user: widget.user,
          client: widget.client,
          date: selectedDay,
        ));
  }

  getTaskList() {
    setState(() {
      _taskListBloc.add(LoadTaskListEvent(
        user: widget.user,
        taskListRequest: TaskListRequest(
          date: selectedDay.toUtc().millisecondsSinceEpoch ~/ 1000,
          clientId: widget.client.id,
        ),
      ));
    });
  }
}
