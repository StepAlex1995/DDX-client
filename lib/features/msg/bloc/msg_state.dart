part of 'msg_bloc.dart';

abstract class MsgState {}

final class MsgInitState extends MsgState {}

final class MsgSendingState extends MsgState {}

final class MsgSendState extends MsgState {}

final class MsgFailureState extends MsgState {
  final int code;
  final String msg;

  MsgFailureState({required this.code, required this.msg});
}
