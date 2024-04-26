import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/models/signup_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/repos/signup_repo.dart';
import 'package:wheel_n_deal/Features/auth/signup/logic/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(const SignupState.initial());

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void emitSignupState(SignupRequestBody signupRequestBody) async {
    emit(const SignupState.loading());
    final response = await _signupRepo.signup(signupRequestBody);
    response.when(
      success: (signupResponse) {
        if (signupResponse.status != 200) {
          emit(SignupState.error(error: signupResponse.message ?? ''));
        } else {
          emit(SignupState.success(signupResponse));
        }
      },
      failure: (error) {
        emit(SignupState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
