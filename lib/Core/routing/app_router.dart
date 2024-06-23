import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_n_deal/Core/di/dependency_injection.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shared_prefs.dart';
import 'package:wheel_n_deal/Core/networking/shared_prefs/shred_prefs_constants.dart';
import 'package:wheel_n_deal/Core/routing/routes.dart';
import 'package:wheel_n_deal/Features/FAQ/presentation/views/app_faq_view.dart';
import 'package:wheel_n_deal/Features/about_app/presentation/views/about_app_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/logic/forgt_password_cubit/forgot_password_cubit.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/create_new_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/forgot_password_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/otp_verification_view.dart';
import 'package:wheel_n_deal/Features/auth/forgot_password/presentation/views/password_changed_view.dart';
import 'package:wheel_n_deal/Features/auth/signin/logic/login_cubit/login_cubit.dart';
import 'package:wheel_n_deal/Features/auth/signin/presentation/views/login_view.dart';
import 'package:wheel_n_deal/Features/auth/signup/logic/signup_cubit/signup_cubit.dart';
import 'package:wheel_n_deal/Features/auth/signup/presentation/views/register_view.dart';
import 'package:wheel_n_deal/Features/auth/signup/presentation/views/successful_register_view.dart';
import 'package:wheel_n_deal/Features/change_language/presentation/views/change_app_language_view.dart';
import 'package:wheel_n_deal/Features/change_password/presentation/views/change_password_view.dart';
import 'package:wheel_n_deal/Features/change_password/presentation/views/password_changed_2_view.dart';
import 'package:wheel_n_deal/Features/commuter/favourite/presentation/views/commuter_favourite_view.dart';
import 'package:wheel_n_deal/Features/commuter/home/presentation/views/commuter_home_view.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/commuter_chat_view.dart';
import 'package:wheel_n_deal/Features/commuter/messages/presentation/views/commuter_messages_view.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/trip_deleted.dart';
import 'package:wheel_n_deal/Features/commuter/my%20trips/presentation/views/my_trips_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/commuter_confirm_order_1_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/commuter_notifications_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/confirmed_deal_view.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/customer_accept_order_details_view.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/commuter_completed_order_details_view.dart';
import 'package:wheel_n_deal/Features/commuter/orders/presentation/views/commuter_orders_view.dart';
import 'package:wheel_n_deal/Features/commuter/pick_order/presentation/views/commuter_canceled_order_view.dart';
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
import 'package:wheel_n_deal/Features/privacy_policy/presentation/views/privacy_policy_view.dart';
import 'package:wheel_n_deal/Features/splash/presentation/views/splash_view.dart';
import 'package:wheel_n_deal/Features/support/presentation/views/support_view.dart';
import 'package:wheel_n_deal/Features/terms_and_conditions/presentation/views/terms_view.dart';
import 'package:wheel_n_deal/Features/user/favourite/presentation/views/user_favourite_view.dart';
import 'package:wheel_n_deal/Features/user/home/presentation/views/user_home_view.dart';
import 'package:wheel_n_deal/Features/user/messages/presentation/views/user_chat_view.dart';
import 'package:wheel_n_deal/Features/user/messages/presentation/views/user_messages_view.dart';
import 'package:wheel_n_deal/Features/user/notifications/presentation/views/user_notifications_view.dart';
import 'package:wheel_n_deal/Features/user/orders/data/models/get_user_orders_response.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_canceled_order_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_completed_order_details_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_order_details_view.dart';
import 'package:wheel_n_deal/Features/user/orders/presentation/views/user_orders_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/done_notify_fav_commuters_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/user_post_order_view.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/user_search_location_view.dart';
import 'package:wheel_n_deal/Features/user/profile/logic/update_user_profile_cubit/update_user_profile_cubit.dart';
import 'package:wheel_n_deal/Features/user/profile/presentation/views/user_edit_profile_view.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/choose_commuter_but_no_order_yet_view.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/commuter_profile_seen_by_the_user_view.dart';
import 'package:wheel_n_deal/Features/user/search_for_commuter/presentation/views/user_search_for_commuter_view_body.dart';
import 'package:wheel_n_deal/Features/user/tracking/presentation/views/commuter_profile_seen_by_user_from_tracking_view.dart';
import 'package:wheel_n_deal/Features/user/tracking/presentation/views/user_track_order_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_top_up_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_visa_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_vodafone_cash_view.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/user_wallet_view.dart';
import 'package:wheel_n_deal/Features/welcome/presentation/views/welcome_view.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.kSplashView:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );

      case Routes.kOnBoardingView:
        return MaterialPageRoute(
          builder: (_) {
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
        );

      case Routes.kWelcomeView:
        return MaterialPageRoute(
          builder: (_) => const WelcomeView(),
        );

      case Routes.kRegisterView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignupCubit>(),
            child: const RegisterView(),
          ),
        );

      case Routes.kLoginView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginView(),
          ),
        );

      case Routes.kUserHomeView:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
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
        );

      case Routes.kCommuterHomeView:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
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
        );

      case Routes.kSuccessfulRegisterView:
        return MaterialPageRoute(
          builder: (_) {
            return const SuccessfulRegisterView();
          },
        );

      case Routes.kForgotPasswodView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const ForgotPasswordView(),
          ),
        );

      case Routes.kOtpVerificationView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const OtpVerificationView(),
          ),
        );

      case Routes.kCreateNewPasswordView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: const CreateNewPasswordView(),
          ),
        );

      case Routes.kPasswordChangedView:
        return MaterialPageRoute(
          builder: (_) => const PasswordChangedView(),
        );

      case Routes.kUserEditProfileView:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<UpdateUserProfileCubit>(),
            child: const UserEditProfileView(),
          ),
        );

      case Routes.kCommuterEditProfileView:
        return MaterialPageRoute(
          builder: (_) => const CommuterEditProfileView(),
        );

      case Routes.kUserNotificationsView:
        return MaterialPageRoute(
          builder: (_) => const UserNotificationsView(),
        );

      case Routes.kCommuterNotificationsView:
        return MaterialPageRoute(
          builder: (_) => const CommuterNotificationsView(),
        );

      case Routes.kCommuterOrdersView:
        return MaterialPageRoute(
          builder: (_) => const CommuterOrdersView(),
        );

      case Routes.kUserOrdersView:
        return MaterialPageRoute(
          builder: (_) => const UserOrdersView(),
        );

      case Routes.kChangeAppLanguageView:
        return MaterialPageRoute(
          builder: (_) => const ChangeAppLanguageView(),
        );

      case Routes.kAboutAppView:
        return MaterialPageRoute(
          builder: (_) => const AboutAppView(),
        );

      case Routes.kTermsView:
        return MaterialPageRoute(
          builder: (_) => const TermsView(),
        );

      case Routes.kPrivacyPolicyView:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyView(),
        );

      case Routes.kSupportView:
        return MaterialPageRoute(
          builder: (_) => const SupportView(),
        );

      case Routes.kCommuterWalletView:
        return MaterialPageRoute(
          builder: (_) => const CommuterWalletView(),
        );

      case Routes.kCommuterVisaView:
        return MaterialPageRoute(
          builder: (_) => const CommuterVisaView(),
        );

      case Routes.kCommuterVodafoneCashView:
        return MaterialPageRoute(
          builder: (_) => const CommuterVodafoneCashView(),
        );

      case Routes.kUserWalletView:
        return MaterialPageRoute(
          builder: (_) => const UserWalletView(),
        );

      case Routes.kUserVisaView:
        return MaterialPageRoute(
          builder: (_) => const UserVisaView(),
        );

      case Routes.kUserVodafoneCashView:
        return MaterialPageRoute(
          builder: (_) => const UserVodafoneCashView(),
        );

      case Routes.kUserTopUpView:
        return MaterialPageRoute(
          builder: (_) => const UserTopUpView(),
        );

      case Routes.kChangePasswordView:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordView(),
        );

      case Routes.kPasswordChanged2View:
        return MaterialPageRoute(
          builder: (_) => const PasswordChanged2View(),
        );

      case Routes.kCommuterConfirmOrder1View:
        return MaterialPageRoute(
          builder: (_) => const CommuterConfirmOrder1View(),
        );

      case Routes.kCommuterPendingOrderDetailesView:
        return MaterialPageRoute(
          builder: (_) => const CommuterPendingOrderDetailsView(),
        );

      case Routes.kUserPostOrderView:
        return MaterialPageRoute(
          builder: (_) {
            final addressController = arguments as TextEditingController?;
            return UserPostOrderView(addressController: addressController);
          },
        );

      case Routes.kUserSearchLocationView:
        return MaterialPageRoute(
          builder: (_) => const UserSearchLocationView(),
        );

      case Routes.kCommuterSearchLocationView:
        return MaterialPageRoute(
          builder: (_) => const CommuterSearchLocationView(),
        );

      case Routes.kCommuterFirstScanQrCodeView:
        return MaterialPageRoute(
          builder: (_) => const CommuterFirstScanQrCodeView(),
        );

      case Routes.kCommuterSecondScanQrCodeView:
        return MaterialPageRoute(
          builder: (_) => const CommuterSecondScanQrCodeView(),
        );

      case Routes.kCommuterMessagesView:
        return MaterialPageRoute(
          builder: (_) => const CommuterMessagesView(),
        );

      case Routes.kCommuterChatView:
        return MaterialPageRoute(
          builder: (_) => const CommuterChatView(),
        );

      case Routes.kUserMessagesView:
        return MaterialPageRoute(
          builder: (_) => const UserMessagesView(),
        );

      case Routes.kUserChatView:
        return MaterialPageRoute(
          builder: (_) => const UserChatView(),
        );

      case Routes.kUserSearchForCommuterViewBody:
        return MaterialPageRoute(
          builder: (_) => const UserSearchForCommuterViewBody(),
        );

      case Routes.kCommuterProfileSeenByTheUserView:
        return MaterialPageRoute(
          builder: (_) => const CommuterProfileSeenByTheUserView(),
        );

      case Routes.kChooseCommuterButNoOrderYetView:
        return MaterialPageRoute(
          builder: (_) => const ChooseCommuterButNoOrderYetView(),
        );

      case Routes.kDoneNotifyFavCommutersView:
        return MaterialPageRoute(
          builder: (_) => const DoneNotifyFavCommutersView(),
        );

      case Routes.kAppFaqView:
        return MaterialPageRoute(
          builder: (_) => const AppFaqView(),
        );

      case Routes.kUserOrderDetailsView:
        return MaterialPageRoute(
          builder: (_) {
            final userOrder = arguments as GetUserOrdersResponseData?;
            return UserOrderDetailsView(userOrder: userOrder);
          },
        );

      case Routes.kCommuterPickOrderView:
        return MaterialPageRoute(
          builder: (_) => const CommuterPickOrderView(),
        );

      case Routes.kCommuterCanceledOrderView:
        return MaterialPageRoute(
          builder: (_) => const CommuterCanceledOrderView(),
        );

      case Routes.kCommuterStartedDeliveyView:
        return MaterialPageRoute(
          builder: (_) => const CommuterStartedDeliveryView(),
        );

      case Routes.kCommuterCompletedOrderDetailsView:
        return MaterialPageRoute(
          builder: (_) => const CommuterCompletedOrderDetailsView(),
        );

      case Routes.kUserCanceledOrderView:
        return MaterialPageRoute(
          builder: (_) => const UserCanceledOrderView(),
        );

      case Routes.kUserCompletedOrderDetailsView:
        return MaterialPageRoute(
          builder: (_) => const UserCompletedOrderDetailsView(),
        );

      case Routes.kCommuterPickOrderDetailsView:
        return MaterialPageRoute(
          builder: (_) => const CommuterPickOrderDetailsView(),
        );

      case Routes.kCommuterOrderPickedView:
        return MaterialPageRoute(
          builder: (_) => const CommuterOrderPickedView(),
        );

      case Routes.kSetAnotherExpectedPriceView:
        return MaterialPageRoute(
          builder: (_) => const SetAnotherExpectedPriceView(),
        );

      case Routes.kDoneWaitForCustomerConfirmationView:
        return MaterialPageRoute(
          builder: (_) => const DoneWaitForCustomerConfirmationView(),
        );

      case Routes.kCommuterFavouriteView:
        return MaterialPageRoute(
          builder: (_) => const CommuterFavouriteView(),
        );

      case Routes.kUserFavouriteView:
        return MaterialPageRoute(
          builder: (_) => const UserFavouriteView(),
        );

      case Routes.kMyTripsView:
        return MaterialPageRoute(
          builder: (_) => const MyTripsView(),
        );

      case Routes.kCommuterPostTripView:
        return MaterialPageRoute(
          builder: (_) => const CommuterPostTripView(),
        );

      case Routes.kTripDeletedView:
        return MaterialPageRoute(
          builder: (_) => const TripDeletedView(),
        );

      case Routes.kCommuterReviewsView:
        return MaterialPageRoute(
          builder: (_) => const CommuterReviewsView(),
        );

      case Routes.kCommuterProfileSeenByUserFromTrackingView:
        return MaterialPageRoute(
          builder: (_) => const CommuterProfileSeenByUserFromTrackingView(),
        );

      case Routes.kUserTrackOrderView:
        return MaterialPageRoute(
          builder: (_) => const UserTrackOrderView(),
        );

      case Routes.kCustomerAcceptOrderDetailsView:
        return MaterialPageRoute(
          builder: (_) => const CustomerAcceptOrderDetailsView(),
        );

      case Routes.kConfirmedDealView:
        return MaterialPageRoute(
          builder: (_) => const ConfirmedDealView(),
        );

      case Routes.kCommuterWithdrawView:
        return MaterialPageRoute(
          builder: (_) => const CommuterWithdrawView(),
        );

      // Default Route
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
    }
  }
}
