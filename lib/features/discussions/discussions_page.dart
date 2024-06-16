import 'package:ddx_trainer/features/discussions/bloc/discussion_bloc.dart';
import 'package:ddx_trainer/features/discussions/widget/discussion_client_tile.dart';
import 'package:ddx_trainer/features/discussions/widget/discussion_trainer_tail.dart';
import 'package:ddx_trainer/repository/msg/abstract_msg_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../exercise_list/widgets/error_info.dart';

class DiscussionsPage extends StatefulWidget {
  final User user;

  const DiscussionsPage({super.key, required this.user});

  @override
  State<DiscussionsPage> createState() => _DiscussionsPageState();
}

class _DiscussionsPageState extends State<DiscussionsPage> {
  final _discussionBloc = DiscussionBloc(GetIt.I<AbstractMsgRepository>());

  @override
  void initState() {
    super.initState();
    if(widget.user.role == User.CLIENT_ROLE){
      _discussionBloc.add(LoadDiscussionClientEvent(user: widget.user));
    }else {
      _discussionBloc.add(LoadDiscussionTrainerEvent(user: widget.user));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
      backgroundColor: AppColor.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  AppTxt.tabDiscussions,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            //////
            BlocBuilder<DiscussionBloc, DiscussionState>(
                bloc: _discussionBloc,
                builder: (context, state) {
                  if (state is DiscussionLoadedState) {
                    return Expanded(
                        child: Material(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(top: 16),
                        itemBuilder: (context, i) {
                          if (widget.user.role == User.CLIENT_ROLE) {
                            return DiscussionClientTile(
                                user: widget.user,
                                discussionClient: state.discussionList[i]);
                          }else {
                            return DiscussionTrainerTail(
                                user: widget.user,
                                discussion: state.discussionList[i]);
                          }
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: theme.dividerColor,
                          );
                        },
                        itemCount: state.discussionList.length,
                      ),
                    ));
                  } else if (state is DiscussionFailureState) {
                    return Column(
                      children: [
                        const SizedBox(height: 250),
                        ErrorInfo(
                          textTitle: state.code == 200 ? state.msg : null,
                          textDescription: state.code == 200
                              ? AppTxt.discussionListEmptyDescription
                              : null,
                        ),
                      ],
                    );
                  } else {
                    return const Column(
                      children: [
                        SizedBox(height: 300),
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    );
                  }
                }),
            //////
          ],
        ),
      ),
    );
  }
}
