part of 'discussion_bloc.dart';

abstract class DiscussionState {}


final class DiscussionInitState extends DiscussionState {}

final class DiscussionLoadingState extends DiscussionState {}

final class DiscussionLoadedState extends DiscussionState {
  final List<Discussion> discussionList;

  DiscussionLoadedState({required this.discussionList});
}

final class DiscussionFailureState extends DiscussionState {
  final int code;
  final String msg;

  DiscussionFailureState({required this.code, required this.msg});
}
