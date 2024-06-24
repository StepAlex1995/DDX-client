import 'dart:io';

import 'package:ddx_trainer/features/feedback_file/bloc/load_feedback_file_bloc.dart';
import 'package:ddx_trainer/features/task/task_client_page.dart';
import 'package:ddx_trainer/repository/exercise/model/load_feedback_file_request.dart';
import 'package:ddx_trainer/repository/task/model/task_model.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../repository/exercise/abstract_exercise_repository.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../widgets/rounded_button.dart';

class LoadFeedbackFilePage extends StatefulWidget {
  final User user;
  final TaskModel task;

  const LoadFeedbackFilePage(
      {super.key, required this.user, required this.task});

  @override
  State<LoadFeedbackFilePage> createState() => _LoadFeedbackFilePageState();
}

class _LoadFeedbackFilePageState extends State<LoadFeedbackFilePage> {
  bool loadSuccess = false;
  XFile? file;
  ImagePicker image = ImagePicker();
  //bool videoFile = false;
  final _loadFeedbackFileBloc =
      LoadFeedbackFileBloc(GetIt.I<AbstractExerciseRepository>());
  //late VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;
  bool preloadFailed = false;

  @override
  void dispose() {
    _loadFeedbackFileBloc.close();
    //_videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
        child: Material(
      child: Container(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 36, bottom: 36),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              AppTxt.titleLoadFeedbackFile,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            Builder(builder: (context) {
              return Container(
                width: 300,
                height: 240,
                color: AppColor.darkBackgroundColor,
                child: file == null
                    ? const Icon(
                  Icons.image,
                  size: 50,
                )
                    : Image.file(File(file!.path), fit: BoxFit.fitHeight),
              );
              /*if (videoFile) {
                if (preloadFailed) {
                  return Center(
                    child: Container(
                      width: 300,
                      height: 240,
                      color: AppColor.darkBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          AppTxt.preloadFailed,
                          style:
                              theme.textTheme.bodySmall!.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }
               return Stack(children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 240,
                      color: AppColor.darkBackgroundColor,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: 240,
                      child: FutureBuilder<bool>(
                        future: started(),
                        builder: (BuildContext context,
                            AsyncSnapshot<bool> snapshot) {
                          if (snapshot.data ?? false) {
                            return AspectRatio(
                              aspectRatio:
                                  _videoPlayerController.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController),
                            );
                          } else {
                            return const Column(
                              children: [
                                SizedBox(height: 70),
                                Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(AppTxt.waitLoadingVideo),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ]);
              } else {
                return Container(
                  width: 300,
                  height: 240,
                  color: AppColor.darkBackgroundColor,
                  child: file == null
                      ? const Icon(
                          Icons.image,
                          size: 50,
                        )
                      : Image.file(File(file!.path), fit: BoxFit.fitHeight),
                );
              }*/
            }),
            Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36, top: 36),
              child: RoundedButton(
                bgrColor: AppColor.secondaryAccentColor,
                text: AppTxt.btnAddFromGallery,
                textStyle: theme.textTheme.labelMedium,
                onPressed: () {
                  getGallery();
                  //checkPermissionGallery();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 36.0, right: 36, top: 18, bottom: 36),
              child: RoundedButton(
                bgrColor: AppColor.secondaryAccentColor,
                text: AppTxt.btnAddFromCamera,
                textStyle: theme.textTheme.labelMedium,
                onPressed: () {
                  getCamera();
                  //checkPermissionCamera();
                },
              ),
            ),
           /* Padding(
              padding: const EdgeInsets.only(
                  left: 36.0, right: 36, top: 18, bottom: 36),
              child: RoundedButton(
                bgrColor: AppColor.secondaryAccentColor,
                text: AppTxt.btnAddVideo,
                textStyle: theme.textTheme.labelMedium,
                onPressed: () {
                  getVideo();
                  //checkPermissionCamera();
                },
              ),
            ),*/
            BlocListener<LoadFeedbackFileBloc, LoadFeedbackFileState>(
              bloc: _loadFeedbackFileBloc,
              listener: (context, state) {
                if (state is LoadFeedbackFileUploaded) {
                  setState(() {
                    loadSuccess = true;
                    file = null;
                    widget.task.fileFeedbackUrl = state.filename;
                  });
                }
              },
              child: BlocBuilder(
                bloc: _loadFeedbackFileBloc,
                builder: (context, state) {
                  if (state is LoadFeedbackFileUploading) {
                    return const Column(
                      children: [
                        SizedBox(height: 30),
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    );
                  } else if (state is LoadFeedbackFileFailure) {
                    return Column(
                      children: [
                        Text(
                          state.msg,
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundedButton(
                          bgrColor: AppColor.primaryColor,
                          text: AppTxt.btnUploadPhoto,
                          textStyle: theme.textTheme.labelMedium,
                          onPressed: () {
                            uploadFeedbackFile();
                          },
                        ),
                      ],
                    );
                  } else {
                    return Builder(builder: (context) {
                      if (file != null) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 9.0, right: 9, top: 18, bottom: 18),
                          child: RoundedButton(
                            bgrColor: AppColor.primaryColor,
                            text: AppTxt.btnUploadPhoto,
                            textStyle: theme.textTheme.labelMedium,
                            onPressed: () {
                              uploadFeedbackFile();
                              //goToExerciseList();
                            },
                          ),
                        );
                      } else if (loadSuccess == true) {
                        return const Text(AppTxt.fileUploadSuccess);
                      } else {
                        return Container();
                      }
                    });
                  }
                },
              ),
            ),
            Builder(builder: (context) {
              if (loadSuccess == true) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                  child: RoundedButton(
                    bgrColor: AppColor.primaryColor,
                    text: AppTxt.btnComplete,
                    textStyle: theme.textTheme.labelMedium,
                    onPressed: () {
                      goToTask();
                    },
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    ));
  }

  uploadFeedbackFile() {
    _loadFeedbackFileBloc.add(LoadFeedbackFileUploadEvent(
      user: widget.user,
      requestData: LoadFeedbackFileRequest(
        taskId: widget.task.id,
        file: file!,
      ),
    ));
  }

  getCamera() async {
    setState(() {
      file = null;
      preloadFailed = false;
    });
    //videoFile = false;
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = img;
    });
  }

  getGallery() async {
    setState(() {
      file = null;
      preloadFailed = false;
    });
    //videoFile = false;
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = img;
    });
  }

/*  Future<bool> started() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.play();
    startedPlaying = true;
    return true;
  }

  getVideo() async {
    setState(() {
      file = null;
      preloadFailed = false;
    });
    videoFile = true;
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        if (result.xFiles.first.name.contains(".mp4")) {
          file = result.xFiles.first;
          _videoPlayerController =
              VideoPlayerController.contentUri(Uri.file(file!.path));
        } else {
          file = null;
          preloadFailed = true;
        }
      });
    } else {
      preloadFailed = true;
    }
  }*/

  goToTask() {
    Navigator.pop(context);
    Navigator.pop(context);
    AppRouter.goToPage(
        context,
        TaskClientPage(
            user: widget.user,
            client: widget.user.convertToClient(),
            task: widget.task));
  }
}
