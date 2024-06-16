part of 'discussion_bloc.dart';

abstract class DiscussionEvent {}

class LoadDiscussionClientEvent extends DiscussionEvent {
  final User user;

  LoadDiscussionClientEvent({required this.user});
}
class LoadDiscussionTrainerEvent extends DiscussionEvent {
  final User user;

  LoadDiscussionTrainerEvent({required this.user});
}
