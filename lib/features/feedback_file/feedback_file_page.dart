import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../config.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../widgets/server_image.dart';

class FeedbackFilePage extends StatefulWidget {
  final User user;
  final String fileUrl;

  const FeedbackFilePage(
      {super.key, required this.fileUrl, required this.user});

  @override
  State<FeedbackFilePage> createState() => _FeedbackFilePageState();
}

class _FeedbackFilePageState extends State<FeedbackFilePage> {
  late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(
            "${Config.server}/api/file/download/${widget.fileUrl.replaceFirst("image/", "")}"),
        httpHeaders: {
          'Authorization': 'bearer ${widget.user.token}',
        });
    //_videoPlayerController =
    //    VideoPlayerController.contentUri(Uri.file(file!.path));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
      backgroundColor: AppColor.backgroundColor,
      child: Center(
        child: Builder(builder: (context) {
          if (widget.fileUrl.contains(".mp4")) {
            return FutureBuilder<bool>(
              future: started(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data ?? false) {
                  return AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController),
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(height: 400),
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(AppTxt.waitLoadingVideo,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium),
                    ],
                  );
                }
              },
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ServerImage(
                filename: widget.fileUrl,
                token: widget.user.token,
                height: double.infinity,
              ),
            );
          }
        }),
      ),
    );
  }

  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }
}
