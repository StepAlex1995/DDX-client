import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repository/client/abstract_client_repository.dart';
import '../../../repository/client/model/client.dart';
import '../../../repository/user_repository/model/user_response.dart';
import '../../../text/text.dart';

part 'client_list_event.dart';

part 'client_list_state.dart';

class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  final AbstractClientRepository clientRepository;

  ClientListBloc(this.clientRepository) : super(ClientListInit()) {
    on<LoadClientListEvent>((event, emit) async {

      try {
        if (state is! ClientListLoaded) {
          emit(ClientListLoading());
        }

        final clientResponse =
            await clientRepository.loadClientList(event.user);

        if (clientResponse.code != 200) {
          if (clientResponse.code == 401) {
            emit(ClientListFailure(code: 401, msg: AppTxt.errorTokenFailed));
          } else {
            emit(ClientListFailure(code: 500, msg: AppTxt.errorServerResponse));
          }
        } else {
          if (clientResponse.data!.clientList.isEmpty) {
            emit(ClientListFailure(code: 200, msg: AppTxt.errorListIsEmpty));
          } else {
            emit(ClientListLoaded(
                exerciseList: clientResponse.data!.clientList));
          }
        }
      } catch (e) {
        emit(ClientListFailure(code: 500, msg: AppTxt.errorServerResponse));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
