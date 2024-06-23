import 'dart:async';

import 'package:ddx_trainer/features/exercise/exercise_page.dart';
import 'package:ddx_trainer/features/msg/bloc/msg_bloc.dart';
import 'package:ddx_trainer/features/msg/bloc/msg_list_bloc.dart';
import 'package:ddx_trainer/features/task/task_client_page.dart';
import 'package:ddx_trainer/features/task/task_trainer_page.dart';
import 'package:ddx_trainer/repository/client/model/client.dart';
import 'package:ddx_trainer/repository/exercise/model/exercise.dart';
import 'package:ddx_trainer/repository/msg/abstract_msg_repository.dart';
import 'package:ddx_trainer/repository/msg/model/send_msg_request.dart';
import 'package:ddx_trainer/repository/task/model/task_model.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:ddx_trainer/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../utils/date_util.dart';
import '../exercise_list/widgets/exercise_tile.dart';

class MessengerPage extends StatefulWidget {
  final User user;
  final Client client;
  final TaskModel task;
  final bool showTask;

  const MessengerPage(
      {super.key,
      required this.user,
      required this.client,
      required this.task,
      required this.showTask});

  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  late ScrollController _scrollController;
  List<String> items = [];

  final _msgBloc = MsgBloc(GetIt.I<AbstractMsgRepository>());
  final _msgListBloc = MsgListBloc(GetIt.I<AbstractMsgRepository>());

  final TextEditingController textMsgController = TextEditingController();
  Timer? timer;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _msgListBloc
        .add(LoadMsgListEvent(user: widget.user, taskId: widget.task.id));
    timer = Timer.periodic(
        const Duration(seconds: 5),
        (Timer t) => _msgListBloc
            .add(LoadMsgListEvent(user: widget.user, taskId: widget.task.id)));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    textMsgController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [header(), bodyChat(), const SizedBox(height: 140)],
            ),
            formChat(),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      color: AppColor.darkBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ExerciseTile(
          exercise: widget.task.exercise,
          user: widget.user,
          getExercise: widget.showTask ? goToTask : goToExercise,
        ),
      ),
    );
  }

  goToExercise(Exercise e) {
    AppRouter.goToPage(context, ExercisePage(user: widget.user, exercise: e));
  }

  goToTask(Exercise e) {
    if (widget.user.role == User.CLIENT_ROLE) {
      AppRouter.goToPage(
          context,
          TaskClientPage(
            user: widget.user,
            client: widget.client,
            task: widget.task,
          ));
    } else if (widget.user.role == User.TRAINER_ROLE) {
      AppRouter.goToPage(
          context,
          TaskTrainerPage(
            user: widget.user,
            client: widget.client,
            task: widget.task,
          ));
    }
  }

  scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 50),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget bodyChat() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: AppColor.backgroundColor,
        ),
        child: BlocListener<MsgListBloc, MsgListState>(
          bloc: _msgListBloc,
          listener: (context, state) {
            scrollToBottom();
          },
          child: BlocBuilder<MsgListBloc, MsgListState>(
            bloc: _msgListBloc,
            builder: (context, state) {
              if (state is MsgListLoadedState) {
                return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.msgList.length,
                    itemBuilder: (context, idx) {
                      return chatTile(
                        (state.msgList[idx].isSendClient &&
                                widget.user.role == User.CLIENT_ROLE ||
                            !state.msgList[idx].isSendClient &&
                                widget.user.role == User.TRAINER_ROLE),
                        state.msgList[idx].text,
                        DateUtil.convertDate(
                            state.msgList[idx].date, 'dd MMM HH:mm'),
                      );
                    });
              }
              return ListView(
                physics: const BouncingScrollPhysics(),
              );
            },
          ),
        ),
      ),
    );
  }

  chatTile(bool isYou, String message, String time) {
    return Row(
      mainAxisAlignment:
          isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        isYou
            ? Text(
                time,
                style: const TextStyle(color: AppColor.semiWhite, fontSize: 12),
              )
            : const SizedBox(),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isYou ? AppColor.semiWhite : AppColor.secondaryAccentColor,
              borderRadius: isYou
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
            ),
            child: Text(message),
          ),
        ),
        !isYou
            ? Text(
                time,
                style: const TextStyle(color: AppColor.semiWhite, fontSize: 12),
              )
            : const SizedBox(),
      ],
    );
  }

  bool isReadyToSending = false;

  Widget formChat() {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          color: AppColor.darkBackgroundColor,
          child: TextField(
            maxLines: 1,
            onChanged: (text) {
              if (text.isEmpty && isReadyToSending ||
                  text.isNotEmpty && !isReadyToSending) {
                setState(() {
                  isReadyToSending = !isReadyToSending;
                });
              }
            },
            controller: textMsgController,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: AppTxt.enterYourMsg,
              suffixIcon: BlocListener<MsgBloc, MsgState>(
                bloc: _msgBloc,
                listener: (context, state) {
                  if (state is MsgSendState) {
                    textMsgController.clear();
                    setState(() {
                      isReadyToSending = false;
                    });
                    _msgListBloc.add(LoadMsgListEvent(
                        user: widget.user, taskId: widget.task.id));
                  }
                },
                child: BlocBuilder<MsgBloc, MsgState>(
                  bloc: _msgBloc,
                  builder: (context, state) {
                    if (state is MsgSendingState) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.darkBackgroundColor),
                          padding: const EdgeInsets.all(14),
                          child: const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        if (isReadyToSending) {
                          sendMessage();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColor.darkBackgroundColor),
                          padding: const EdgeInsets.all(14),
                          child: Icon(
                            Icons.send_rounded,
                            color: isReadyToSending
                                ? AppColor.primaryColor
                                : AppColor.appGrey,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              filled: true,
              fillColor: AppColor.appGrey,
              labelStyle: const TextStyle(fontSize: 12),
              contentPadding: const EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.appGrey),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.appGrey),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendMessage() {
    if (textMsgController.value.text.isEmpty) {
      return;
    }
    _msgBloc.add(SendMsgEvent(
      user: widget.user,
      sendMsgRequest: SendMsgRequest(
        taskId: widget.task.id,
        trainerId: widget.user.role == User.CLIENT_ROLE
            ? widget.user.trainerId
            : widget.user.selfTrainerId,
        clientId: widget.client.id,
        text: textMsgController.value.text,
        date: DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000,
        isSendClient: widget.user.role == User.CLIENT_ROLE,
      ),
    ));
  }
}
