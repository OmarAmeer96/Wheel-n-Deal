import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wheel_n_deal/Core/functions/image_picker_bottom_sheet.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Features/user/profile/logic/update_user_profile_cubit/update_user_profile_cubit.dart';
import 'package:wheel_n_deal/Features/user/profile/logic/update_user_profile_cubit/update_user_profile_state.dart';
import 'package:wheel_n_deal/constants.dart';
import '../../../../../../Core/utils/assets.dart';
import '../../../../../../Core/utils/styles.dart';
import '../../../../../../Core/widgets/custom_main_text_form_field.dart';

class UserEditProfileViewBody extends StatefulWidget {
  const UserEditProfileViewBody({super.key});

  @override
  State<UserEditProfileViewBody> createState() =>
      _UserEditProfileViewBodyState();
}

class _UserEditProfileViewBodyState extends State<UserEditProfileViewBody> {
  String? fullName;
  String? phoneNumber;
  String? gender;
  String? city;
  String? nationalId;

  String selectedGender = SharedPrefs.getString(key: kGender) ?? "MALE";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocListener<UpdateUserProfileCubit, UpdateUserProfileState>(
          listenWhen: (previous, current) =>
              current is Loading || current is Success || current is Error,
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                );
              },
              success: (updateUserProfileResponse) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(updateUserProfileResponse.message),
                    duration: const Duration(seconds: 3),
                  ),
                );
                if (updateUserProfileResponse.message ==
                    "Profile updated successfully.") {
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                }
              },
              error: (error) {
                setupErrorState(context,
                    "An error occurred while updating the profile. $error");
              },
            );
          },
          child: Form(
            key: context.read<UpdateUserProfileCubit>().formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: SizedBox(
                              height: 115,
                              width: 115,
                              child: Stack(
                                clipBehavior: Clip.none,
                                fit: StackFit.expand,
                                children: [
                                  Positioned(
                                    child: SharedPrefs.getString(
                                                key: kProfilePhotoURL) !=
                                            null
                                        ? CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              SharedPrefs.getString(
                                                key: kProfilePhotoURL,
                                              )!,
                                            ),
                                          )
                                        : const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: AssetImage(
                                              AssetsData.profileImage,
                                            ),
                                          ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: -25,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x59FF981A),
                                            blurRadius: 8,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 27,
                                        backgroundColor: Colors.white,
                                        child: RawMaterialButton(
                                          onPressed: () async {
                                            requestPermission();
                                            imagePickerBottomSheet(context,
                                                onTap1: () {
                                              _pickImageFromCamera();
                                            }, onTap2: () {
                                              _pickImageFromGallery();
                                            });
                                          },
                                          elevation: 2.0,
                                          fillColor: const Color(0xFF191D31),
                                          padding: const EdgeInsets.all(15.0),
                                          shape: const CircleBorder(),
                                          child: SvgPicture.asset(
                                            AssetsData.cameraIcon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Full Name',
                              style: Styles.manropeBold32.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomMainTextFormField(
                            onChanged: (data) {
                              fullName = data;
                            },
                            controller: context
                                .read<UpdateUserProfileCubit>()
                                .fullNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name.';
                              }
                              return null;
                            },
                            hintText: SharedPrefs.getString(key: kFullName) ==
                                        null ||
                                    SharedPrefs.getString(key: kFullName)!
                                        .isEmpty
                                ? 'Enter Full Name'
                                : '${SharedPrefs.getString(key: kFullName)}',
                            borderColor: const Color(0xFFA3A3A3),
                            focusedBorderColor: const Color(0xff55433c),
                            enabledBorderColor: const Color(0xFFA3A3A3),
                            inputType: TextInputType.text,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SvgPicture.asset(AssetsData.userName),
                            ),
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Phone number',
                              style: Styles.manropeBold32.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomMainTextFormField(
                            onChanged: (data) {
                              phoneNumber = data;
                            },
                            controller: context
                                .read<UpdateUserProfileCubit>()
                                .phoneNumberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password.';
                              }
                              return null;
                            },
                            hintText: SharedPrefs.getString(key: kPhone) ==
                                        null ||
                                    SharedPrefs.getString(key: kPhone)!.isEmpty
                                ? 'Input phone number'
                                : '${SharedPrefs.getString(key: kPhone)}',
                            borderColor: const Color(0xFFA3A3A3),
                            focusedBorderColor: const Color(0xff55433c),
                            enabledBorderColor: const Color(0xFFA3A3A3),
                            inputType: TextInputType.text,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SvgPicture.asset(AssetsData.phoneIcon),
                            ),
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'City',
                              style: Styles.manropeBold32.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomMainTextFormField(
                            onChanged: (data) {
                              city = data;
                            },
                            controller: context
                                .read<UpdateUserProfileCubit>()
                                .cityController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a name.';
                              }
                              return null;
                            },
                            hintText: SharedPrefs.getString(key: kCity) ==
                                        null ||
                                    SharedPrefs.getString(key: kCity)!.isEmpty
                                ? 'Enter City'
                                : '${SharedPrefs.getString(key: kCity)}',
                            borderColor: const Color(0xFFA3A3A3),
                            focusedBorderColor: const Color(0xff55433c),
                            enabledBorderColor: const Color(0xFFA3A3A3),
                            inputType: TextInputType.text,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SvgPicture.asset(AssetsData.citySvg),
                            ),
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'National ID',
                              style: Styles.manropeBold32.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomMainTextFormField(
                            onChanged: (data) {
                              nationalId = data;
                            },
                            controller: context
                                .read<UpdateUserProfileCubit>()
                                .nationalIdController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the national ID.';
                              }
                              return null;
                            },
                            hintText: SharedPrefs.getString(key: kNationalId) ==
                                        null ||
                                    SharedPrefs.getString(key: kNationalId)!
                                        .isEmpty
                                ? 'Enter National ID'
                                : '${SharedPrefs.getString(key: kNationalId)}',
                            borderColor: const Color(0xFFA3A3A3),
                            focusedBorderColor: const Color(0xff55433c),
                            enabledBorderColor: const Color(0xFFA3A3A3),
                            inputType: TextInputType.text,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: SvgPicture.asset(AssetsData.naionalIdSvg),
                            ),
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gender',
                              style: Styles.manropeBold32.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetsData.genderSvg,
                                width: 22,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        focusColor: const Color(0xff99A0A8),
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                          kPrimaryColor,
                                        ),
                                        value: 'MALE',
                                        groupValue: selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value!;
                                            context
                                                .read<UpdateUserProfileCubit>()
                                                .genderController
                                                .text = value;
                                          });
                                        },
                                      ),
                                      Text(
                                        'Male',
                                        style: Styles.poppinsSemiBold16
                                            .copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        focusColor: const Color(0xff99A0A8),
                                        fillColor:
                                            const MaterialStatePropertyAll(
                                          kPrimaryColor,
                                        ),
                                        value: 'FEMALE',
                                        groupValue: selectedGender,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value!;
                                            context
                                                .read<UpdateUserProfileCubit>()
                                                .genderController
                                                .text = value;
                                          });
                                        },
                                      ),
                                      Text(
                                        'Female',
                                        style: Styles.poppinsSemiBold16
                                            .copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomMainButton(
                              text: "Save Changes",
                              onPressed: () {
                                BlocProvider.of<UpdateUserProfileCubit>(context)
                                    .emitUpdateProfileState();
                              },
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> requestPermission() async {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      context.read<UpdateUserProfileCubit>().selectedImage =
          File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      context.read<UpdateUserProfileCubit>().selectedImage =
          File(returnedImage.path);
    });
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(
          Icons.error,
          color: Colors.red,
          size: 32,
        ),
        content: Text(
          error,
          textAlign: TextAlign.center,
          style: Styles.manropeBold32.copyWith(
            color: kPrimaryColor,
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(
              'Got it',
              style: Styles.manropeBold32.copyWith(
                color: kPrimaryColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
