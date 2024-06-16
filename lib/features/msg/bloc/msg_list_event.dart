part of 'msg_list_bloc.dart';

abstract class MsgListEvent {}

class MsgListInit extends MsgListEvent {}

class LoadMsgListEvent extends MsgListEvent {
  final User user;
  final int taskId;

  LoadMsgListEvent({required this.user, required this.taskId});
}
