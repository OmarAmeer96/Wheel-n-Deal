import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/user/profile/data/repos/update_user_profile_repo.dart';
import 'package:wheel_n_deal/Features/user/profile/logic/update_user_profile_cubit/update_user_profile_state.dart';
import '../../../../../Core/networking/shared_prefs/shared_prefs.dart';

class UpdateUserProfileCubit extends Cubit<UpdateUserProfileState> {
  final UpdateUserProfileRepo _updateUserProfileRepo;
  UpdateUserProfileCubit(this._updateUserProfileRepo)
      : super(const UpdateUserProfileState.initial());

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController genderController = TextEditingController(text: "MALE");

  File? selectedImage;

  void emitUpdateProfileState() async {
    emit(const UpdateUserProfileState.loading());
    final response = await _updateUserProfileRepo.updateUserProfile(
      SharedPrefs.getString(key: kToken)!,
      SharedPrefs.getInt(key: kUserId)!,
      fullNameController.text,
      genderController.text,
      cityController.text,
      selectedImage,
      nationalIdController.text,
      phoneNumberController.text,
    );
    response.when(
      success: (updateUserProfileResponse) async {
        if (updateUserProfileResponse.status != 200) {
          emit(
            UpdateUserProfileState.error(
              error: updateUserProfileResponse.message ?? '',
            ),
          );
        } else {
          // Save User's Fullname
          if ((fullNameController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kFullName) == null) ||
              (fullNameController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kFullName) != null)) {
            await SharedPrefs.setString(
              key: kFullName,
              value: fullNameController.text,
            );
          }
          // Save User's Gender
          if ((genderController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kGender) == null) ||
              (genderController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kGender) != null)) {
            await SharedPrefs.setString(
              key: kGender,
              value: genderController.text,
            );
          }
          // Save User's City
          if ((cityController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kCity) == null) ||
              (cityController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kCity) != null)) {
            await SharedPrefs.setString(
              key: kCity,
              value: cityController.text,
            );
          }
          // Save User's National ID
          if ((nationalIdController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kNationalId) == null) ||
              (nationalIdController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kNationalId) != null)) {
            await SharedPrefs.setString(
              key: kNationalId,
              value: nationalIdController.text,
            );
          }
          // Save User's Phone Number
          if ((phoneNumberController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kPhone) == null) ||
              (phoneNumberController.text.isNotEmpty &&
                  SharedPrefs.getString(key: kPhone) != null)) {
            await SharedPrefs.setString(
              key: kPhone,
              value: phoneNumberController.text,
            );
          }
          emit(UpdateUserProfileState.success(updateUserProfileResponse));
        }
      },
      failure: (error) {
        emit(UpdateUserProfileState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!'));
      },
    );
  }
}
