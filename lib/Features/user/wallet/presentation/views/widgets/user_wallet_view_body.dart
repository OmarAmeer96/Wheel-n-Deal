import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/widgets/payment_method_item.dart';
import 'package:wheel_n_deal/Features/user/wallet/presentation/views/widgets/user_balance_item.dart';

class UserWalletViewBody extends StatelessWidget {
  const UserWalletViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Focus.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const UserBalanceItem(
                isHere: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Methods of depositing profits",
                  style: Styles.manropeSemiBold16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kUserVisaView);
                },
                borderRadius: BorderRadius.circular(14),
                child: const PaymentMethodItem(
                  icon: AssetsData.visaIcon,
                  text1: 'Visa',
                  text2: "6895 3526 8456 ****",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kUserVodafoneCashView);
                },
                borderRadius: BorderRadius.circular(14),
                child: const PaymentMethodItem(
                  icon: AssetsData.vodafoneCashIcon,
                  text1: 'Vodafone Cash',
                  text2: "01222858555",
                ),
              ),
              const SizedBox(
                height: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
