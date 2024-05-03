import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/repos/forgot_password_repo.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_state.dart';
import '../../../../../Core/networking/shared_prefs/shared_prefs.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo _signupRepo;
  ForgotPasswordCubit(this._signupRepo)
      : super(const ForgotPasswordState.initial());

  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  void emitSendOTPState() async {
    emit(const ForgotPasswordState.loading());
    final response = await _signupRepo.sendOTP(
      phoneController.text,
    );
    response.when(
      success: (forgotPasswordResponse) async {
        if (forgotPasswordResponse.status != 200) {
          emit(ForgotPasswordState.error(
              error: forgotPasswordResponse.message ?? ''));
        } else {
          // Save User's phoneNumber
          await SharedPrefs.setString(
            key: kPhone,
            value: phoneController.text,
          );
          emit(ForgotPasswordState.success(forgotPasswordResponse));
        }
      },
      failure: (error) {
        emit(ForgotPasswordState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!'));
      },
    );
  }
}
