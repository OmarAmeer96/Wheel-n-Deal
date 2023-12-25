import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/otp_verification_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/create_new_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/password_changed_view.dart';
import 'package:wheel_n_deal/Features/auth/login/presentation/views/login_view.dart';
import 'package:wheel_n_deal/Features/auth/register/presentation/views/register_view.dart';
import 'package:wheel_n_deal/Features/auth/register/presentation/views/successful_register_view.dart';
import 'package:wheel_n_deal/Features/commuter/home/presentation/views/commuter_home_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/commuter_notifications_view.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/commuter_orders_view.dart';
import 'package:wheel_n_deal/Features/commuter/profile/presentation/views/commuter_edit_profile_view.dart';
import 'package:wheel_n_deal/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:wheel_n_deal/Features/splash/presentation/views/splash_view.dart';
import 'package:wheel_n_deal/Features/user/home/presentation/views/user_home_view.dart';
import 'package:wheel_n_deal/Features/user/notifications/presentation/views/user_notifications_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_orders_view.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/user_edit_profile_view.dart';
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

  static const kUserEditProfileView = '/userEditProfileView';
  static const kCommuterEditProfileView = '/commuterEditProfileView';

  static const kUserNotificationsView = '/userNotificationsView';
  static const kCommuterNotificationsView = '/commuterNotificationsView';

  static const kCommuterOrdersView = '/commuterOrdersView';

  static const kUserOrdersView = '/userOrdersView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kSuccessfulRegisterView,
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
        path: '/',
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
      GoRoute(
        path: kUserEditProfileView,
        builder: (context, state) => const UserEditProfileView(),
      ),
      GoRoute(
        path: kCommuterEditProfileView,
        builder: (context, state) => const CommuterEditProfileView(),
      ),
      GoRoute(
        path: kUserNotificationsView,
        builder: (context, state) => const UserNotificationsView(),
      ),
      GoRoute(
        path: kCommuterNotificationsView,
        builder: (context, state) => const CommuterNotificationsView(),
      ),
      GoRoute(
        path: kCommuterOrdersView,
        builder: (context, state) => const CommuterOrdersView(),
      ),
      GoRoute(
        path: kUserOrdersView,
        builder: (context, state) => const UserOrdersView(),
      ),
    ],
  );
}
