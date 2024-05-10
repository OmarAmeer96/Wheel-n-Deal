import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Core/networking/dio_factory.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/data/repos/forgot_password_repo.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_cubit.dart';
import 'package:wheel_n_deal/Features/auth/signin/data/repos/login_repo.dart';
import 'package:wheel_n_deal/Features/auth/signin/logic/login_cubit/login_cubit.dart';
import 'package:wheel_n_deal/Features/auth/signup/data/repos/signup_repo.dart';
import 'package:wheel_n_deal/Features/auth/signup/logic/signup_cubit/signup_cubit.dart';
import 'package:wheel_n_deal/Features/user/post_order/data/repos/post_order_repo.dart';
import 'package:wheel_n_deal/Features/user/post_order/logic/post_order_cubit/post_order_cubit.dart';
import 'package:wheel_n_deal/Features/user/profile/data/repos/update_user_profile_repo.dart';
import 'package:wheel_n_deal/Features/user/profile/logic/update_user_profile_cubit/update_user_profile_cubit.dart';

// TODO: If there was an error, so make it here await an make the {DioFactory} Future.

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Sigin Repo & Cubit
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // Signup Repo & Cubit
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // Forgot Password Repo & Cubit
  getIt.registerLazySingleton<ForgotPasswordRepo>(
      () => ForgotPasswordRepo(getIt()));
  getIt
      .registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(getIt()));

  // Update User Profile Repo & Cubit
  getIt.registerLazySingleton<UpdateUserProfileRepo>(
      () => UpdateUserProfileRepo(getIt()));
  getIt.registerFactory<UpdateUserProfileCubit>(
      () => UpdateUserProfileCubit(getIt()));

  // Post Order Repo & Cubit
  getIt.registerLazySingleton<PostOrderRepo>(() => PostOrderRepo(getIt()));
  getIt.registerFactory<PostOrderCubit>(() => PostOrderCubit(getIt()));
}
