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
  TextEditingController rolController = TextEditingController();

  void emitSignupState() async {
    emit(const SignupState.loading());
    final response = await _signupRepo.signup(
      SignupRequestBody(
        username: usernameController.text,
        phone: phoneController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        role: rolController.text,
      ),
    );
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

  // saveUserData(SignupRequestBody userData) async {
  //   final SignupRequestBody user = SignupRequestBody(
  //     username: userData.username,
  //     phone: userData.phone,
  //     password: userData.password,
  //     confirmPassword: userData.confirmPassword,
  //     role: userData.role,
  //   );
  //   emit(const SignupState.loading());
  //   try {
  //     var userDataBox = Hive.box<SignupRequestBody>(kUserDataBox);
  //     await userDataBox.add(user);
  //   } catch (e) {
  //     emit(SignupState.error(error: 'Error: $e'));
  //   }
  // }

  // List<SignupRequestBody> userData;
  // fetchUserData() async {
  //   var userDataBox = Hive.box<SignupRequestBody>(kUserDataBox);
  //   await userData[0].put();
  //   userData = userDataBox.values.toList();
  //   emit(SignupState.success(userData.toString()));
  // }
}
