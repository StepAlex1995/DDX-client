import 'dart:io';

import 'package:ddx_trainer/features/home_trainer/home_trainer_page.dart';
import 'package:ddx_trainer/features/load_photo_exercise/bloc/load_photo_exercise_bloc.dart';
import 'package:ddx_trainer/repository/exercise/model/load_photo_exercise_request.dart';
import 'package:ddx_trainer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../repository/exercise/abstract_exercise_repository.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../text/text.dart';
import '../../theme/theme.dart';
import '../widgets/rounded_button.dart';

class LoadPhotoExercise extends StatefulWidget {
  final User user;
  final int exerciseId;

  const LoadPhotoExercise(
      {super.key, required this.user, required this.exerciseId});

  @override
  State<LoadPhotoExercise> createState() => _LoadPhotoExerciseState();
}

class _LoadPhotoExerciseState extends State<LoadPhotoExercise> {
  bool loadSuccess = false;
  int photoNumber = 0;

  XFile? file;
  ImagePicker image = ImagePicker();

  final _loadPhotoExerciseBloc =
      LoadPhotoExerciseBloc(GetIt.I<AbstractExerciseRepository>());

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
                AppTxt.titlePhotoExecute,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                height: 240,
                color: AppColor.darkBackgroundColor,
                child: file == null
                    ? const Icon(
                        Icons.image,
                        size: 50,
                      )
                    : Image.file(File(file!.path), fit: BoxFit.fitHeight),
              ),
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
              Text(
                "${AppTxt.uploadedFilesCount}\t$photoNumber",
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 30),
              ),
              BlocListener<LoadPhotoExerciseBloc, LoadPhotoExerciseState>(
                bloc: _loadPhotoExerciseBloc,
                listener: (context, state) {
                  if (state is LoadPhotoExerciseUploaded) {
                    setState(() {
                      loadSuccess = true;
                      photoNumber++;
                      file = null;
                    });
                  }
                },
                child: BlocBuilder(
                    bloc: _loadPhotoExerciseBloc,
                    builder: (context, state) {
                      if (state is LoadPhotoExerciseUploading) {
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
                      } else if (state is LoadPhotoExerciseFailure) {
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
                                uploadPhoto();
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
                                  uploadPhoto();
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
                    }),
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
                        goToExerciseList();
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
      ),
    );
  }

  checkPermissionGallery() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    if (statuses[Permission.storage] != PermissionStatus.granted) {
      return;
    }
    getGallery();
  }

  checkPermissionCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
    ].request();
    if (statuses[Permission.camera] != PermissionStatus.granted) {
      return;
    }
    getCamera();
  }

  uploadPhoto() {
    _loadPhotoExerciseBloc.add(LoadPhotoExerciseUploadInitEvent(
        user: widget.user,
        requestData: LoadPhotoExerciseRequest(
            exerciseId: widget.exerciseId, number: photoNumber, file: file!)));
  }

  goToExerciseList() {
    AppRouter.goToPage(
        context, HomeTrainerPage(user: widget.user, indexTab: 1), true);
  }

  getCamera() async {
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = img;
    });
  }

  getGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = img;
    });
  }
}
