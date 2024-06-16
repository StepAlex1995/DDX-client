part of 'client_list_bloc.dart';

abstract class ClientListState extends Equatable {}

final class ClientListInit extends ClientListState {
  @override
  List<Object> get props => [];
}

final class ClientListLoading extends ClientListState {
  @override
  List<Object> get props => [];
}

final class ClientListLoaded extends ClientListState {
  final List<Client> exerciseList;

  ClientListLoaded({required this.exerciseList});

  @override
  List<Object> get props => [exerciseList];
}

final class ClientListFailure extends ClientListState {
  final int code;
  final String msg;

  ClientListFailure({required this.code, required this.msg});

  @override
  List<Object> get props => [code, msg];
}
