import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_visa_vodacash_text_field.dart';
import 'package:wheel_n_deal/constants.dart';

class UserVisaViewBody extends StatefulWidget {
  const UserVisaViewBody({super.key});

  @override
  State<UserVisaViewBody> createState() => _UserVisaViewBodyState();
}

class _UserVisaViewBodyState extends State<UserVisaViewBody> {
  String? cardNumber;
  DateTime? expiryDate;
  String? cvv;
  String? name;

  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Focus.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: _form,
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "By Visa",
                        style: Styles.manropeRegular16.copyWith(
                          fontSize: 20,
                          letterSpacing: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomVisaVodaCashTextField(
                      onChanged: (data) {
                        cardNumber = data;
                      },
                      controller: _cardNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the card number.';
                        } else if (value.length < 16) {
                          return 'Card number must be 16 numbers length.';
                        }
                        return null;
                      },
                      labelText: "Card Number",
                      hintText: "1234 7843 1237 1279",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(AssetsData.visaIcon),
                      ),
                      enabled: true,
                      inputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null &&
                                  pickedDate != expiryDate) {
                                setState(() {
                                  expiryDate = pickedDate;
                                  _expiryDateController.text =
                                      DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);
                                });
                              }
                            },
                            child: CustomVisaVodaCashTextField(
                              onChanged: (data) {
                                expiryDate = DateFormat('dd/MM/yyyy')
                                    .format(data as DateTime) as DateTime?;
                              },
                              controller: _expiryDateController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the expiry date.';
                                }
                                return null;
                              },
                              labelText: "Expiry Date",
                              hintText: "19/6/2030",
                              enabled: false,
                              prefixIcon: const Icon(
                                Icons.date_range,
                                color: kPrimaryColor,
                              ),
                              inputType: TextInputType.datetime,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: CustomVisaVodaCashTextField(
                              onChanged: (data) {
                                cvv = data.toString();
                              },
                              controller: _cvvController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the cvv number.';
                                } else if (value.length < 3) {
                                  return 'Card number must be 3 numbers length.';
                                }
                                return null;
                              },
                              labelText: "CVV",
                              hintText: "123",
                              enabled: true,
                              prefixIcon: const Icon(
                                Icons.password,
                                color: kPrimaryColor,
                              ),
                              inputType: TextInputType.number,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    CustomVisaVodaCashTextField(
                      onChanged: (data) {
                        name = data;
                      },
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name.';
                        }
                        return null;
                      },
                      labelText: "Name",
                      hintText: "Omar Ameer",
                      enabled: true,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      inputType: TextInputType.text,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: CustomMainButton(
                    text: "Add Card",
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 60,
                                      height: 6,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFA3A3A3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 48,
                                    ),
                                    SvgPicture.asset(
                                      AssetsData.successIcon,
                                      height: 140,
                                    ),
                                    const SizedBox(
                                      height: 42,
                                    ),
                                    Text(
                                      'Added Successfully!',
                                      style: Styles.manropeExtraBold32
                                          .copyWith(fontSize: 26),
                                    ),
                                    const Spacer(),
                                    CustomMainButton(
                                      text: "Back",
                                      onPressed: () {
                                        GoRouter.of(context)
                                            .push(AppRouter.kUserWalletView);
                                      },
                                      color: kPrimaryColor,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
