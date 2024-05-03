import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/models/validate_otp_request_body.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/repos/forgot_password_repo.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_state.dart';
import '../../../../../Core/networking/shared_prefs/shared_prefs.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo _forgotPasswordRepo;
  ForgotPasswordCubit(this._forgotPasswordRepo)
      : super(const ForgotPasswordState.initial());

  // Send OTP
  final formKey1 = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  // Validate OTP
  final formKey2 = GlobalKey<FormState>();
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  // Send OTP
  void emitSendOTPState() async {
    emit(const ForgotPasswordState.loading());
    final response = await _forgotPasswordRepo.sendOTP(
      phoneController.text,
    );
    response.when(
      success: (sendOTPResponse) async {
        if (sendOTPResponse.status != 200) {
          emit(ForgotPasswordState.error(
              error: sendOTPResponse.message ?? ''));
        } else {
          // Save User's phoneNumber
          await SharedPrefs.setString(
            key: kForgotPasswordPhoneNumber,
            value: phoneController.text,
          );
          emit(ForgotPasswordState.success(sendOTPResponse));
        }
      },
      failure: (error) {
        emit(ForgotPasswordState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!'));
      },
    );
  }

  // Validate OTP
  void emitValidateOTP() async {
    emit(const ForgotPasswordState.loading());
    final response = await _forgotPasswordRepo.validateOTP(
      ValidateOTPRequestBody(
        otpNumber:
            "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}",
        phoneNumber: SharedPrefs.getString(key: kForgotPasswordPhoneNumber)!,
      ),
    );
    response.when(
      success: (validateOTPResponse) async {
        if (validateOTPResponse.status != 200) {
          emit(ForgotPasswordState.error(
              error: validateOTPResponse.message ?? ''));
        } else {
          emit(ForgotPasswordState.success(validateOTPResponse));
        }
      },
      failure: (error) {
        emit(ForgotPasswordState.error(
            error: error.apiErrorModel.message ?? 'Something went wrong!'));
      },
    );
  }
}
