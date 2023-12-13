import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/views/otp_verification_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/views/create_new_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/views/forgot_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/views/password_changed_view.dart';
import 'package:wheel_n_deal/Features/auth/login/presentation/views/login_view.dart';
import 'package:wheel_n_deal/Features/auth/register/presentation/views/register_view.dart';
import 'package:wheel_n_deal/Features/auth/register/presentation/views/successful_register_view.dart';
import 'package:wheel_n_deal/Features/commuter/home/views/commuter_home_view.dart';
import 'package:wheel_n_deal/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:wheel_n_deal/Features/splash/presentation/views/splash_view.dart';
import 'package:wheel_n_deal/Features/user/home/views/user_home_view.dart';
import 'package:wheel_n_deal/Features/welcome/presentation/views/welcome_view.dart';

abstract class AppRouter {
  static const kOnBoardingView = '/onBoardingView';
  static const kHomeView = '/homeView';
  static const kWelcomeView = '/welcomeView';
  static const kRegisterView = '/registerView';
  static const kLoginView = '/loginView';
  static const kUserHomeView = '/userHomeView';
  static const kCommuterHomeView = '/commuterHomeView';
  static const kSuccessfulRegisterView = '/successfulRegisterView';
  static const kForgotPasswodView = '/forgotPasswodView';
  static const kOtpVerificationView = '/otpVerificationView';
  static const kCreateNewPasswordView = '/createNewPasswordView';
  static const kPasswordChangedView = '/passwordChangedView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: kWelcomeView,
        builder: (context, state) => const WelcomeView(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: kUserHomeView,
        builder: (context, state) => const UserHomeView(),
      ),
      GoRoute(
        path: kCommuterHomeView,
        builder: (context, state) => const CommuterHomeView(),
      ),
      GoRoute(
        path: kSuccessfulRegisterView,
        builder: (context, state) => const SuccessfulRegisterView(),
      ),
      GoRoute(
        path: kForgotPasswodView,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: kOtpVerificationView,
        builder: (context, state) => const OtpVerificationView(),
      ),
      GoRoute(
        path: kCreateNewPasswordView,
        builder: (context, state) => const CreateNewPasswordView(),
      ),
      GoRoute(
        path: kPasswordChangedView,
        builder: (context, state) => const PasswordChangedView(),
      ),
    ],
  );
}
