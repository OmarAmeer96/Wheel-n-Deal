import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Core/networking/dio_factory.dart';
import 'package:wheel_n_deal/Features/auth/login/data/repos/loign_repo.dart';
import 'package:wheel_n_deal/Features/auth/login/logic/login_cubit/login_cubit.dart';

// TODO: If there was an error, so make it here await an make the {DioFactory} Future.

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // Login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));
}
