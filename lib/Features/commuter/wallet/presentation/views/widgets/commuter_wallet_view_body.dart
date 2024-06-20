import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wheel_n_deal/Core/utils/app_router_old.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/widgets/payment_method_item.dart';
import 'package:wheel_n_deal/Features/commuter/wallet/presentation/views/widgets/prev_profits_item.dart';

class CommuterWalletViewBody extends StatelessWidget {
  const CommuterWalletViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                color: const Color(0xFF1D272F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "My Balance",
                          style: Styles.manropeRegular14.copyWith(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(500),
                          onTap: () {
                            GoRouter.of(context)
                                .push(AppRouter.kCommuterWithdrawView);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Text(
                                  "Withdraw",
                                  style: Styles.cairoSemiBold.copyWith(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                  AssetsData.withdrawIcon,
                                  width: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "\$4,875.00",
                          style: Styles.cairoSemiBold.copyWith(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
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
                style: Styles.manropeSemiBold16,
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
                GoRouter.of(context).push(AppRouter.kCommuterVodafoneCashView);
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Previous profits",
                style: Styles.manropeRegular14.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: PrevProfitsItem(
                      icon: AssetsData.ordersIcon,
                      text: "Clothes",
                      date: "Mar 18, 2022",
                      price: "25.5",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
