import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:ddx_trainer/features/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:ddx_trainer/features/home_client/home_client_page.dart';
import 'package:ddx_trainer/repository/user_repository/model/update_user_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../repository/user_repository/abstract_user_repository.dart';
import '../../repository/user_repository/model/user_response.dart';
import '../../router/app_router.dart';
import '../../text/text.dart';
import '../widgets/bgr_img.dart';
import '../widgets/rounded_button.dart';
import '../widgets/text_input.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user});

  final User user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState(user);
}

class _EditProfilePageState extends State<EditProfilePage> {
  final User user;

  _EditProfilePageState(this.user);

  final _editProfileBloc = EditProfileBloc(GetIt.I<AbstractUserRepository>());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DateTime birthDate = DateTime(1995, 1, 1);
  bool isMan = true;

  @override
  void initState() {
    super.initState();
    _editProfileBloc.add(EditProfileInitEvent());
  }

  void onChangeTextInput(String txt) {
    _editProfileBloc.add(EditProfileInitEvent());
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoPageScaffold(
        child: Stack(
      children: [
        const BgrImg(
          assetImg: AssetImage('assets/img/bgr_auth3.jpg'),
        ),
        Container(
          decoration: BoxDecoration(color: theme.canvasColor),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView(
                children: [
                  SizedBox(
                    height: 180,
                    child: Text(
                      AppTxt.editProfileTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextInput(
                    onChange: (text) {
                      onChangeTextInput(text);
                    },
                    controller: nameController,
                    icon: Icons.person,
                    hint: AppTxt.name,
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                    isPassword: false,
                  ),
                  const SizedBox(height: 12),
                  TextInput(
                    onChange: (text) {
                      onChangeTextInput(text);
                    },
                    controller: phoneController,
                    icon: Icons.phone,
                    hint: AppTxt.phone,
                    inputType: TextInputType.phone,
                    inputAction: TextInputAction.done,
                    isPassword: false,
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: CupertinoRadioChoice(
                        choices: const {
                          'male': AppTxt.male,
                          'female': AppTxt.female
                        },
                        onChange: (selectedGender) {
                          isMan = selectedGender == 'male';
                        },
                        initialKeyValue: 'male'),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    AppTxt.birthdate,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      //backgroundColor: theme.primaryColor,
                      mode: CupertinoDatePickerMode.date,
                      maximumDate: DateTime.now(),
                      minimumYear: 1900,
                      initialDateTime: DateTime(1995, 1, 1),
                      onDateTimeChanged: (DateTime newDateTime) {
                        birthDate = newDateTime;
                      },
                    ),
                  ),
                  BlocListener<EditProfileBloc, EditProfileState>(
                    bloc: _editProfileBloc,
                    listener: (context, state) {
                      if (state is EditProfileSuccessState) {
                        AppRouter.goToPage(
                            context, HomeClientPage(user: state.user), true);
                      }
                    },
                    child: BlocBuilder<EditProfileBloc, EditProfileState>(
                      bloc: _editProfileBloc,
                      builder: (context, state) {
                        if (state is EditProfileProgressState) {
                          return Column(
                            children: [
                              const SizedBox(height: 62),
                              CircularProgressIndicator(
                                color: theme.primaryColor,
                              )
                            ],
                          );
                        } else if (state is EditProfileErrorState) {
                          return Column(
                            children: [
                              const SizedBox(height: 22),
                              Text(
                                state.msg,
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RoundedButton(
                                onPressed: () {
                                  updateUserProfile();
                                },
                                bgrColor: theme.primaryColor,
                                textStyle: theme.textTheme.labelMedium,
                                text: AppTxt.btnCreateAccount,
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              const SizedBox(height: 48),
                              RoundedButton(
                                onPressed: () {
                                  updateUserProfile();
                                },
                                bgrColor: theme.primaryColor,
                                textStyle: theme.textTheme.labelMedium,
                                text: AppTxt.btnEditProfile,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }

  updateUserProfile() {
    DateFormat dateFormat =
        DateFormat("yyyy-MM-ddT00:00:00Z"); // how you want it to be formatted
    String dateString = dateFormat.format(birthDate);

    _editProfileBloc.add(TryEditProfileEvent(
        user: user,
        updateUserModel: UpdateUserRequestModel(
          name: nameController.text,
          isMan: isMan,
          phone: phoneController.text,
          birthdate: dateString,
        )));
  }
}
