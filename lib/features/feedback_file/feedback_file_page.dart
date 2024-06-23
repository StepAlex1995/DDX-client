import 'package:flutter/cupertino.dart';

import '../../repository/user_repository/model/user_response.dart';
import '../../theme/theme.dart';
import '../widgets/server_image.dart';

class FeedbackFilePage extends StatelessWidget {
  final User user;
  final String fileUrl;

  const FeedbackFilePage(
      {super.key, required this.fileUrl, required this.user});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColor.backgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ServerImage(
            filename: fileUrl,
            token: user.token,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
