import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/widgets/payment_method_item.dart';

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
              Container(
                width: Responsive.screenWidth(context),
                height: 85,
                decoration: ShapeDecoration(
                  color: const Color(0xFF1D272F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    bottom: 16,
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Balance",
                            style: Styles.manropeRegular14.copyWith(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "\$0",
                            style: Styles.cairoSemiBold.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "Top Up",
                        style: Styles.manropeRegular14.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Methods of depositing profits",
                  style: Styles.manropeRegular16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.kCommuterVisaView);
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
                  GoRouter.of(context)
                      .push(AppRouter.kCommuterVodafoneCashView);
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
