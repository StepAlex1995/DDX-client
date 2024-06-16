import 'dart:async';

import 'package:ddx_trainer/features/client_list/bloc/client_list_bloc.dart';
import 'package:ddx_trainer/features/client_list/wisgets/client_tile.dart';
import 'package:ddx_trainer/repository/client/abstract_client_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../exercise_list/widgets/error_info.dart';

class ClientListPage extends StatefulWidget {
  final User user;

  const ClientListPage({super.key, required this.user});

  @override
  State<ClientListPage> createState() => _ClientListPageState(user: user);
}

class _ClientListPageState extends State<ClientListPage> {
  final User user;
  final _clientListBloc = ClientListBloc(GetIt.I<AbstractClientRepository>());

  _ClientListPageState({required this.user});

  @override
  void initState() {
    super.initState();
    loadClientList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            AppTxt.tabClients,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                final completer = Completer();
                _clientListBloc
                    .add(LoadClientListEvent(completer: completer, user: user));
                return completer.future;
              },
              child: BlocBuilder<ClientListBloc, ClientListState>(
                bloc: _clientListBloc,
                builder: (context, state) {
                  if (state is ClientListLoaded) {
                    return Material(
                      child: ListView.separated(
                          itemBuilder: (context, i) {
                            return ClientTile(
                                user: user, client: state.exerciseList[i]);
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: theme.dividerColor,
                            );
                          },
                          itemCount: state.exerciseList.length),
                    );
                  } else if (state is ClientListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    );
                  } else if (state is ClientListFailure) {
                    return Column(
                      children: [
                        const SizedBox(height: 250),
                        ErrorInfo(
                          btnAction: () {
                            state.code == 200 ? null : loadClientList();
                          },
                          textTitle: state.code == 200 ? state.msg : null,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                  ///////////////
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadClientList() {
    _clientListBloc.add(LoadClientListEvent(user: user));
  }
}
