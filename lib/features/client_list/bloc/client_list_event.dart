part of 'client_list_bloc.dart';

abstract class ClientListEvent extends Equatable {
  get completer => completer;
}

class LoadClientListEvent extends ClientListEvent {
  final Completer? completer;
  final User user;

  LoadClientListEvent({this.completer, required this.user});

  @override
  List<Object?> get props => [completer];
}
