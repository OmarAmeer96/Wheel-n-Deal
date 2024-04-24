import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Features/auth/login/data/models/login_request_body.dart';
import 'package:wheel_n_deal/Features/auth/login/data/repos/loign_repo.dart';
import 'package:wheel_n_deal/Features/auth/login/logic/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  void emitLoginState(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(loginRequestBody);
    response.when(
      success: (loginResponse) {
        emit(LoginState.success(loginResponse));
      },
      failure: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
