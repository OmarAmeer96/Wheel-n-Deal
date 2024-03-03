import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
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

  final List<Widget> _widgets = [
    const MyWidget1(),
    const MyWidget2(),
  ];
  Widget? _selectedWidget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Withdraw My Balance",
                  style: Styles.manropeSemiBold16.copyWith(
                    fontSize: 21,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 50),
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
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          Text(
                            "LE",
                            style: Styles.manropeSemiBold16.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 35),
              Container(
                width: double.infinity,
                height: 100,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFF898A8D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                child: DropdownButton<Widget>(
                  itemHeight: 80,
                  isExpanded: true,
                  hint: const Text("Choose to withdraw money to"),
                  style: Styles.manropeBold32.copyWith(fontSize: 16),
                  value: _selectedWidget,
                  items: _widgets
                      .map(
                        (widget) => DropdownMenuItem(
                          value: widget,
                          child: widget,
                        ),
                      )
                      .toList(),
                  onChanged: (widget) {
                    setState(() {
                      _selectedWidget = widget;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget1 extends StatelessWidget {
  const MyWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Container(
        height: 80,
        width: Responsive.screenWidth(context) * 0.7,
        decoration: ShapeDecoration(
          color: const Color(0xFF898A8D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AssetsData.vodafoneCashIcon,
                width: 16,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vodafone Cash",
                    style: Styles.manropeRegular15.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "01554111002",
                    style: Styles.manropeRegular15.copyWith(fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        height: 80,
        width: Responsive.screenWidth(context) * 0.7,
        decoration: ShapeDecoration(
          color: const Color(0xFF898A8D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AssetsData.visaIcon,
                width: 16,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visa",
                    style: Styles.manropeRegular15.copyWith(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    ".... .... .... 2138",
                    style: Styles.manropeRegular15.copyWith(fontSize: 14),
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
