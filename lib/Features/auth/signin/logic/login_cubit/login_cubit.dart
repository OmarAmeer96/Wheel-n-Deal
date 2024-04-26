import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/models/login_request_body.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/repos/login_repo.dart';
import 'package:wheel_n_deal/Features/auth/signin/logic/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void emitLoginState(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(loginRequestBody);
    response.when(
      success: (loginResponse) {
        if (loginResponse.status != 200) {
          emit(LoginState.error(error: loginResponse.message ?? ''));
        } else {
          emit(LoginState.success(loginResponse));
        }
      },
      failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
