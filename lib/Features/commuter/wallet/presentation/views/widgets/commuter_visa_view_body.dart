import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wheel_n_deal/Core/utils/app_router.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
import 'package:wheel_n_deal/Core/widgets/custom_visa_text_field.dart';
import 'package:wheel_n_deal/constants.dart';

class CommuterVisaViewBody extends StatefulWidget {
  const CommuterVisaViewBody({super.key});

  @override
  State<CommuterVisaViewBody> createState() => _CommuterVisaViewBodyState();
}

class _CommuterVisaViewBodyState extends State<CommuterVisaViewBody> {
  String? cardNumber;
  DateTime? expiryDate;
  int? cvv;
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
            child: Column(
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
                CustomVisaTextField(
                  labelText: "Card Number",
                  hintText: "1234 7843 1237 1279",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(AssetsData.visaIcon),
                  ),
                  controller: _cardNumberController,
                  enabled: true,
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
                          if (pickedDate != null && pickedDate != expiryDate) {
                            setState(() {
                              expiryDate = pickedDate;
                              _expiryDateController.text =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                            });
                          }
                        },
                        child: CustomVisaTextField(
                          labelText: "Expiry Date",
                          hintText: "19/6/2030",
                          controller: _expiryDateController,
                          enabled: false,
                          prefixIcon: const Icon(
                            Icons.date_range,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: CustomVisaTextField(
                          labelText: "CVV",
                          hintText: "123",
                          controller: _cvvController,
                          enabled: true,
                          prefixIcon: const Icon(
                            Icons.password,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 37,
                ),
                CustomVisaTextField(
                  labelText: "Name",
                  hintText: "Omar Ameer",
                  controller: _nameController,
                  enabled: true,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                ),
                const Spacer(),
                CustomMainButton(
                  text: "Add Card",
                  onPressed: () async {
                    if (_form.currentState!.validate()) {
                      showModalBottomSheet(
                        isScrollControlled: true,
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
                            child: SingleChildScrollView(
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
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
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}