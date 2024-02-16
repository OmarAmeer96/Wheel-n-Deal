import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/about_app/presentation/views/about_app_view.dart';
import 'package:wheel_n_deal/Core/change_password/presentation/views/change_password_view.dart';
import 'package:wheel_n_deal/Core/change_password/presentation/views/password_changed_2_view.dart';
import 'package:wheel_n_deal/Core/privacy_policy/presentation/views/privacy_policy_view.dart';
import 'package:wheel_n_deal/Core/support/presentation/views/support_view.dart';
import 'package:wheel_n_deal/Core/terms_and_conditions/presentation/views/terms_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/otp_verification_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/create_new_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/password_changed_view.dart';
import 'package:wheel_n_deal/Features/auth/login/presentation/views/login_view.dart';
import 'package:wheel_n_deal/Features/auth/register/presentation/views/register_view.dart';
import 'package:wheel_n_deal/Features/auth/register/presentation/views/successful_register_view.dart';
import 'package:wheel_n_deal/Core/change_language/presentation/views/change_app_language_view.dart';
import 'package:wheel_n_deal/Features/commuter/home/presentation/views/commuter_home_view.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/chat_view.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/messages_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/commuter_confirm_order_1_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/commuter_notifications_view.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/commuter_orders_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_order_details_view.dart';
import 'package:wheel_n_deal/Features/commuter/profile/presentation/views/commuter_edit_profile_view.dart';
import 'package:wheel_n_deal/Features/commuter/scan%20qr%20code/first%20scan%20qr%20code/presentation/views/commuter_first_scan_qr_code_view.dart';
import 'package:wheel_n_deal/Features/commuter/scan%20qr%20code/second%20scan%20qr%20code/presentation/views/commuter_second_scan_qr_code_view.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/commuter_visa_view.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/commuter_vodafone_cash_view.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/commuter_wallet_view.dart';
import 'package:wheel_n_deal/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:wheel_n_deal/Features/splash/presentation/views/splash_view.dart';
import 'package:wheel_n_deal/Features/user/home/presentation/views/user_home_view.dart';
import 'package:wheel_n_deal/Features/user/notifications/presentation/views/user_notifications_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_orders_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/user_post_order_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/user_search_location_view.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/user_edit_profile_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_top_up_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_visa_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_vodafone_cash_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_wallet_view.dart';
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

  static const kChangeAppLanguageView = '/changeAppLanguageView';

  static const kAboutAppView = '/aboutAppView';

  static const kTermsView = '/termsView';

  static const kPrivacyPolicyView = '/privacyPolicy';

  static const kSupportView = '/supportView';

  static const kCommuterWalletView = '/commuterWalletView';
  static const kCommuterVisaView = '/commuterVisaView';
  static const kCommuterVodafoneCashView = '/commuterVodafoneCashView';

  static const kUserWalletView = '/userWalletView';
  static const kUserVisaView = '/userVisaView';
  static const kUserVodafoneCashView = '/userVodafoneCashView';

  static const kUserTopUpView = '/userTopUpView';

  static const kChangePasswordView = '/changePasswordView';

  static const kPasswordChanged2View = '/passwordChanged2View';

  static const kCommuterConfirmOrder1View = '/commuterConfirmOrder1View';

  static const kCommuterOrderDetailesView = '/commuterOrderDetailesView';

  static const kUserPostOrderView = '/userPostOrderView';

  static const kUserSearchLocationView = '/userSearchLocationView';

  static const kCommuterFirstScanQrCodeView = '/commuterFirstScanQrCodeView';

  static const kCommuterSecondScanQrCodeView = '/commuterSecondScanQrCodeView';

  static const kCommuterMessagesView = '/commuterMessagesView';

  static const kCommuterChatView = '/commuterChatView';

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
      GoRoute(
        path: kChangeAppLanguageView,
        builder: (context, state) => const ChangeAppLanguageView(),
      ),
      GoRoute(
        path: kChangeAppLanguageView,
        builder: (context, state) => const ChangeAppLanguageView(),
      ),
      GoRoute(
        path: kAboutAppView,
        builder: (context, state) => const AboutAppView(),
      ),
      GoRoute(
        path: kTermsView,
        builder: (context, state) => const TermsView(),
      ),
      GoRoute(
        path: kPrivacyPolicyView,
        builder: (context, state) => const PrivacyPolicyView(),
      ),
      GoRoute(
        path: kSupportView,
        builder: (context, state) => const SupportView(),
      ),
      GoRoute(
        path: kCommuterWalletView,
        builder: (context, state) => const CommuterWalletView(),
      ),
      GoRoute(
        path: kCommuterVisaView,
        builder: (context, state) => const CommuterVisaView(),
      ),
      GoRoute(
        path: kCommuterVodafoneCashView,
        builder: (context, state) => const CommuterVodafoneCashView(),
      ),
      GoRoute(
        path: kUserWalletView,
        builder: (context, state) => const UserWalletView(),
      ),
      GoRoute(
        path: kUserVisaView,
        builder: (context, state) => const UserVisaView(),
      ),
      GoRoute(
        path: kUserVodafoneCashView,
        builder: (context, state) => const UserVodafoneCashView(),
      ),
      GoRoute(
        path: kUserTopUpView,
        builder: (context, state) => const UserTopUpView(),
      ),
      GoRoute(
        path: kChangePasswordView,
        builder: (context, state) => const ChangePasswordView(),
      ),
      GoRoute(
        path: kPasswordChanged2View,
        builder: (context, state) => const PasswordChanged2View(),
      ),
      GoRoute(
        path: kCommuterConfirmOrder1View,
        builder: (context, state) => const CommuterConfirmOrder1View(),
      ),
      GoRoute(
        path: kCommuterOrderDetailesView,
        builder: (context, state) => const CommuterOrderDetailsView(),
      ),
      GoRoute(
        path: kUserPostOrderView,
        builder: (context, state) => const UserPostOrderView(),
      ),
      GoRoute(
        path: kUserSearchLocationView,
        builder: (context, state) => const UserSearchLocationView(),
      ),
      GoRoute(
        path: kCommuterFirstScanQrCodeView,
        builder: (context, state) => const CommuterFirstScanQrCodeView(),
      ),
      GoRoute(
        path: kCommuterSecondScanQrCodeView,
        builder: (context, state) => const CommuterSecondScanQrCodeView(),
      ),
      GoRoute(
        path: kCommuterMessagesView,
        builder: (context, state) => const MessagesView(),
      ),
      GoRoute(
        path: kCommuterChatView,
        builder: (context, state) => const ChatView(),
      ),
    ],
  );
}
