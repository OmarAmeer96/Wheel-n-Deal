import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/di/dependency_injection.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Features/FAQ/presentation/views/app_faq_view.dart';
import 'package:wheel_n_deal/Features/about_app/presentation/views/about_app_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_cubit.dart';
import 'package:wheel_n_deal/Features/auth/signin/logic/login_cubit/login_cubit.dart';
import 'package:wheel_n_deal/Features/auth/signup/logic/signup_cubit/signup_cubit.dart';
import 'package:wheel_n_deal/Features/change_password/presentation/views/change_password_view.dart';
import 'package:wheel_n_deal/Features/change_password/presentation/views/password_changed_2_view.dart';
import 'package:wheel_n_deal/Features/privacy_policy/presentation/views/privacy_policy_view.dart';
import 'package:wheel_n_deal/Features/support/presentation/views/support_view.dart';
import 'package:wheel_n_deal/Features/terms_and_conditions/presentation/views/terms_view.dart';
import 'package:wheel_n_deal/Features/commuter/favourite/presentation/views/commuter_favourite_view.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/trip_deleted.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/my_trips_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/confirmed_deal_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/customer_accept_order_details_view.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/commuter_completed_order_details_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_canceled_order_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/otp_verification_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/create_new_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/password_changed_view.dart';
import 'package:wheel_n_deal/Features/auth/signin/presentation/views/login_view.dart';
import 'package:wheel_n_deal/Features/auth/signup/presentation/views/register_view.dart';
import 'package:wheel_n_deal/Features/auth/signup/presentation/views/successful_register_view.dart';
import 'package:wheel_n_deal/Features/change_language/presentation/views/change_app_language_view.dart';
import 'package:wheel_n_deal/Features/commuter/home/presentation/views/commuter_home_view.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/commuter_chat_view.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/commuter_messages_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/commuter_confirm_order_1_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/commuter_notifications_view.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/commuter_orders_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_order_picked_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_pending_order_details_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_pick_order_details_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_pick_order_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_started_delivery_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/done_wait_for_customer_confirmation_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/set_another_expected_price_view.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/presentation/views/commuter_post_trip_view.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/presentation/views/commuter_search_location_view.dart';
import 'package:wheel_n_deal/Features/commuter/profile/presentation/views/commuter_edit_profile_view.dart';
import 'package:wheel_n_deal/Features/commuter/reviews/presentation/views/commuter_reviews_view.dart';
import 'package:wheel_n_deal/Features/commuter/scan%20qr%20code/first%20scan%20qr%20code/presentation/views/commuter_first_scan_qr_code_view.dart';
import 'package:wheel_n_deal/Features/commuter/scan%20qr%20code/second%20scan%20qr%20code/presentation/views/commuter_second_scan_qr_code_view.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/commuter_visa_view.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/commuter_vodafone_cash_view.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/commuter_wallet_view.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/commuter_withdraw_view.dart';
import 'package:wheel_n_deal/Features/onboarding/presentation/views/onboarding_view.dart';
import 'package:wheel_n_deal/Features/splash/presentation/views/splash_view.dart';
import 'package:wheel_n_deal/Features/user/favourite/presentation/views/user_favourite_view.dart';
import 'package:wheel_n_deal/Features/user/home/presentation/views/user_home_view.dart';
import 'package:wheel_n_deal/Features/user/messages/presentation/views/user_chat_view.dart';
import 'package:wheel_n_deal/Features/user/messages/presentation/views/user_messages_view.dart';
import 'package:wheel_n_deal/Features/user/notifications/presentation/views/user_notifications_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_canceled_order_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_completed_order_details_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_order_details_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_orders_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/done_notify_fav_commuters_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/user_post_order_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/user_search_location_view.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/user_edit_profile_view.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/choose_commuter_but_no_order_yet_view.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/commuter_profile_seen_by_the_user_view.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/user_search_for_commuter_view_body.dart';
import 'package:wheel_n_deal/Features/user/tracking/presentation/views/commuter_profile_seen_by_user_from_tracking_view.dart';
import 'package:wheel_n_deal/Features/user/tracking/presentation/views/uer_track_order_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_top_up_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_visa_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_vodafone_cash_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_wallet_view.dart';
import 'package:wheel_n_deal/Features/welcome/presentation/views/welcome_view.dart';

import '../networking/shared_prefs/shared_prefs.dart';

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

  static const kCommuterPendingOrderDetailesView = '/commuterOrderDetailesView';

  static const kUserPostOrderView = '/userPostOrderView';

  static const kUserSearchLocationView = '/userSearchLocationView';

  static const kCommuterSearchLocationView = '/commuterSearchLocationView';

  static const kCommuterFirstScanQrCodeView = '/commuterFirstScanQrCodeView';

  static const kCommuterSecondScanQrCodeView = '/commuterSecondScanQrCodeView';

  static const kCommuterMessagesView = '/commuterMessagesView';

  static const kCommuterChatView = '/commuterChatView';

  static const kUserMessagesView = '/userMessageView';

  static const kUserChatView = '/userChatView';

  static const kUserSearchForCommuterViewBody =
      '/userSearchForCommuterViewBody';

  static const kCommuterProfileSeenByTheUserView =
      '/commuterProfileSeenByTheUserView';

  static const kChooseCommuterButNoOrderYetView =
      '/chooseCommuterButNoOrderYetView';

  static const kDoneNotifyFavCommutersView = '/doneNotifyFavCommutersView';

  static const kAppFaqView = '/appFaqView';

  static const kUserOrderDetailsView = '/userOrderDetailsView';

  static const kCommuterPickOrderView = '/commuterPickOrderView';

  static const kCommuterCanceledOrderView = '/commuterCanceledOrderView';

  static const kCommuterStartedDeliveyView = '/commuterStartedDeliveyView';

  static const kCommuterCompletedOrderDetailsView =
      '/commuterCompletedOrderDetailsView';

  static const kUserCanceledOrderView = '/userCanceledOrderView';

  static const kUserCompletedOrderDetailsView =
      '/kuserCompletedOrderDetailsView';

  static const kCommuterPickOrderDetailsView = '/commuterPickOrderDetailsView';

  static const kCommuterOrderPickedView = '/commuterOrderPickedView';

  static const kSetAnotherExpectedPriceView = '/setAnotherExpectedPriceView';

  static const kDoneWaitForCustomerConfirmationView =
      '/doneWaitForCustomerConfirmationView';
  static const kCommuterFavouriteView = '/commuterFavouriteView';
  static const kUserFavouriteView = '/userFavouriteView';

  static const kMyTripsView = '/myTripsView';

  static const kCommuterPostTripView = '/postTripView';

  static const kTripDeletedView = '/tripDeletedView';

  static const kCommuterReviewsView = '/commuterReviewsView';

  static const kCommuterProfileSeenByUserFromTrackingView =
      '/commuterProfileSeenByUserFromTrackingView';

  static const kUserTrackOrderView = '/userTrackOrderView';

  static const kCustomerAcceptOrderDetailsView =
      '/customerAcceptOrderDetailsView';

  static const kConfirmedDealView = '/confirmedDealView';

  static const kCommuterWithdrawView = '/commuterWithdrawView';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) {
          if (SharedPrefs.getString(key: kToken) == null) {
            return const OnBoardingView();
          } else if ((SharedPrefs.getString(key: kRole) == 'USER') &&
              (SharedPrefs.getString(key: kToken) != null)) {
            return const UserHomeView();
          } else if ((SharedPrefs.getString(key: kRole) == 'COMMUTER') &&
              (SharedPrefs.getString(key: kToken) != null)) {
            return const CommuterHomeView();
          } else {
            return const OnBoardingView();
          }
        },
      ),
      GoRoute(
        path: kWelcomeView,
        builder: (context, state) => const WelcomeView(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SignupCubit>(),
          child: const RegisterView(),
        ),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginView(),
        ),
      ),
      GoRoute(
        path: kUserHomeView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<LoginCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<SignupCubit>(),
            ),
          ],
          child: const UserHomeView(),
        ),
      ),
      GoRoute(
        path: kCommuterHomeView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<LoginCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<SignupCubit>(),
            ),
          ],
          child: const CommuterHomeView(),
        ),
      ),
      GoRoute(
        path: kSuccessfulRegisterView,
        builder: (context, state) => const SuccessfulRegisterView(),
      ),
      GoRoute(
        path: kForgotPasswodView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ForgotPasswordCubit>(),
          child: const ForgotPasswordView(),
        ),
      ),
      GoRoute(
        path: kOtpVerificationView,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ForgotPasswordCubit>(),
          child: const OtpVerificationView(),
        ),
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
        path: kCommuterPendingOrderDetailesView,
        builder: (context, state) => const CommuterPendingOrderDetailsView(),
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
        path: kCommuterSearchLocationView,
        builder: (context, state) => const CommuterSearchLocationView(),
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
        builder: (context, state) => const CommuterMessagesView(),
      ),
      GoRoute(
        path: kCommuterChatView,
        builder: (context, state) => const CommuterChatView(),
      ),
      GoRoute(
        path: kUserMessagesView,
        builder: (context, state) => const UserMessagesView(),
      ),
      GoRoute(
        path: kUserChatView,
        builder: (context, state) => const UserChatView(),
      ),
      GoRoute(
        path: kUserSearchForCommuterViewBody,
        builder: (context, state) => const UserSearchForCommuterViewBody(),
      ),
      GoRoute(
        path: kCommuterProfileSeenByTheUserView,
        builder: (context, state) => const CommuterProfileSeenByTheUserView(),
      ),
      GoRoute(
        path: kChooseCommuterButNoOrderYetView,
        builder: (context, state) => const ChooseCommuterButNoOrderYetView(),
      ),
      GoRoute(
        path: kDoneNotifyFavCommutersView,
        builder: (context, state) => const DoneNotifyFavCommutersView(),
      ),
      GoRoute(
        path: kAppFaqView,
        builder: (context, state) => const AppFaqView(),
      ),
      GoRoute(
        path: kUserOrderDetailsView,
        builder: (context, state) => const UserOrderDetailsView(),
      ),
      GoRoute(
        path: kCommuterPickOrderView,
        builder: (context, state) => const CommuterPickOrderView(),
      ),
      GoRoute(
        path: kCommuterCanceledOrderView,
        builder: (context, state) => const CommuterCanceledOrderView(),
      ),
      GoRoute(
        path: kCommuterStartedDeliveyView,
        builder: (context, state) => const CommuterStartedDeliveryView(),
      ),
      GoRoute(
        path: kCommuterCompletedOrderDetailsView,
        builder: (context, state) => const CommuterCompletedOrderDetailsView(),
      ),
      GoRoute(
        path: kUserCanceledOrderView,
        builder: (context, state) => const UserCanceledOrderView(),
      ),
      GoRoute(
        path: kUserCompletedOrderDetailsView,
        builder: (context, state) => const UserCompletedOrderDetailsView(),
      ),
      GoRoute(
        path: kCommuterPickOrderDetailsView,
        builder: (context, state) => const CommuterPickOrderDetailsView(),
      ),
      GoRoute(
        path: kCommuterOrderPickedView,
        builder: (context, state) => const CommuterOrderPickedView(),
      ),
      GoRoute(
        path: kSetAnotherExpectedPriceView,
        builder: (context, state) => const SetAnotherExpectedPriceView(),
      ),
      GoRoute(
        path: kDoneWaitForCustomerConfirmationView,
        builder: (context, state) =>
            const DoneWaitForCustomerConfirmationView(),
      ),
      GoRoute(
        path: kCommuterFavouriteView,
        builder: (context, state) => const CommuterFavouriteView(),
      ),
      GoRoute(
        path: kUserFavouriteView,
        builder: (context, state) => const CommuterFavouriteView(),
      ),
      GoRoute(
        path: kUserFavouriteView,
        builder: (context, state) => const UserFavouriteView(),
      ),
      GoRoute(
        path: kMyTripsView,
        builder: (context, state) => const MyTripsView(),
      ),
      GoRoute(
        path: kCommuterPostTripView,
        builder: (context, state) => const CommuterPostTripView(),
      ),
      GoRoute(
        path: kTripDeletedView,
        builder: (context, state) => const TripDeletedView(),
      ),
      GoRoute(
        path: kCommuterReviewsView,
        builder: (context, state) => const CommuterReviewsView(),
      ),
      GoRoute(
        path: kCommuterProfileSeenByUserFromTrackingView,
        builder: (context, state) =>
            const CommuterProfileSeenByUserFromTrackingView(),
      ),
      GoRoute(
        path: kUserTrackOrderView,
        builder: (context, state) => const UsertrackOrderView(),
      ),
      GoRoute(
        path: kCustomerAcceptOrderDetailsView,
        builder: (context, state) => const CustomerAcceptOrderDetailsView(),
      ),
      GoRoute(
        path: kConfirmedDealView,
        builder: (context, state) => const ConfirmedDealView(),
      ),
      GoRoute(
        path: kCommuterWithdrawView,
        builder: (context, state) => const CommuterWithdrawView(),
      ),
    ],
  );
}
