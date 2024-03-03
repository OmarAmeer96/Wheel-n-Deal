import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class CommuterWithdrawViewBody extends StatefulWidget {
  const CommuterWithdrawViewBody({super.key});

  @override
  State<CommuterWithdrawViewBody> createState() =>
      _CommuterWithdrawViewBodyState();
}

class _CommuterWithdrawViewBodyState extends State<CommuterWithdrawViewBody> {
  int? withdrawBalance = 0;
  final _withdrawBalanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Withdraw My Balance",
                style: Styles.manropeSemiBold16.copyWith(
                  fontSize: 21,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 130,
                        child: Expanded(
                          child: TextField(
                            onChanged: (value) {
                              value = withdrawBalance.toString();
                            },
                            controller: _withdrawBalanceController,
                            style: Styles.manropeSemiBold16.copyWith(
                              fontSize: 50,
                            ),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '20',
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "LE",
                            style: Styles.manropeSemiBold16.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Withdraw My Balance",
                    style: Styles.manropeSemiBold16.copyWith(
                      fontSize: 21,
                      letterSpacing: 1.6,
                    ),
                  ),
                  Text(
                    "LE 875.00",
                    style: Styles.manropeBold32.copyWith(
                      fontSize: 22,
                      letterSpacing: 1.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
