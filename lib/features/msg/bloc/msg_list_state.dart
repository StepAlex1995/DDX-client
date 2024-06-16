part of 'msg_list_bloc.dart';

abstract class MsgListState {}


final class MsgListInitState extends MsgListState {}

final class MsgListLoadingState extends MsgListState {}

final class MsgListLoadedState extends MsgListState {
  final List<MsgModel> msgList;

  MsgListLoadedState({required this.msgList});
}

final class MsgListFailureState extends MsgListState {
  final int code;
  final String msg;

  MsgListFailureState({required this.code, required this.msg});
}
