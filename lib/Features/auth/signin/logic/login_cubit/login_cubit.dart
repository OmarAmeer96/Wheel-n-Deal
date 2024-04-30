import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/login_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/repos/login_repo.dart';
import 'package:wheel_n_deal/Features/auth/signin/logic/login_cubit/login_state.dart';

import '../../../../../Core/networking/shared_prefs/shared_prefs.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void emitLoginState() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        username: usernameController.text,
        password: passwordController.text,
      ),
    );
    response.when(
      success: (loginResponse) async {
        if (loginResponse.status != 200) {
          emit(LoginState.error(error: loginResponse.message ?? ''));
        } else {
          await SharedPrefs.setString(
            key: 'token',
            value: loginResponse.userData!.token!,
          );
          await SharedPrefs.setString(
            key: 'username',
            value: usernameController.text,
          );
          await SharedPrefs.setString(
            key: 'password',
            value: passwordController.text,
          );
          emit(LoginState.success(loginResponse));
        }
      },
      failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
