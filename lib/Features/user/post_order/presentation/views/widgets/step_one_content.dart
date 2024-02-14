import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/is_valid_phone_number.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_text_form_field.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/make_order_select_location_item.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/step_one_item.dart';
import 'package:wheel_n_deal/constants.dart';

class StepOneContent extends StatefulWidget {
  const StepOneContent({
    super.key,
  });

  @override
  State<StepOneContent> createState() => _StepOneContentState();
}

class _StepOneContentState extends State<StepOneContent> {
  String? from;
  String? to;
  String? senderName;
  String? senderPhoneNumber;
  String? receiverPhoneNumber;

  // ignore: unused_field
  final _fromController = TextEditingController();
  // ignore: unused_field
  final _toController = TextEditingController();
  final _senderNameController = TextEditingController();
  final _senderPhoneNumberController = TextEditingController();
  final _receiverPhoneNumberController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _form,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sender Details',
                style: Styles.manropeExtraBold32.copyWith(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SteponeItem(
              widget: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Address Details',
                      style: Styles.manropeRegular15.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MakeOrderSelectLocationIte(
                    text: 'From',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MakeOrderSelectLocationIte(
                    text: 'To',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SteponeItem(
              widget: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sender's Name",
                      style: Styles.manropeRegular15.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainTextFormField(
                    borderColor: Colors.transparent,
                    fillColor: Colors.transparent,
                    hintText: 'Input your name..',
                    controller: _senderNameController,
                    onChanged: (value) {
                      senderName = value;
                    },
                    contentPadding: 7,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter sender's name.";
                      }
                      return null;
                    },
                    focusedBorderColor: const Color(0xff55433c),
                    enabledBorderColor: kPrimaryColor,
                    inputType: TextInputType.text,
                    prefixIcon: const Icon(Icons.person),
                    obscureText: false,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SteponeItem(
              widget: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sender's phone number",
                      style: Styles.manropeRegular15.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainTextFormField(
                    borderColor: Colors.transparent,
                    fillColor: Colors.transparent,
                    hintText: 'Input your number..',
                    controller: _senderPhoneNumberController,
                    onChanged: (value) {
                      senderName = value;
                    },
                    contentPadding: 7,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter sender's phone number.";
                      } else if (!isValidPhoneNumber(value)) {
                        return 'Please enter a valid Egyptian phone number.';
                      }
                      return null;
                    },
                    focusedBorderColor: const Color(0xff55433c),
                    enabledBorderColor: kPrimaryColor,
                    inputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.phone),
                    obscureText: false,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SteponeItem(
              widget: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Receiver's phone number",
                      style: Styles.manropeRegular15.copyWith(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMainTextFormField(
                    borderColor: Colors.transparent,
                    fillColor: Colors.transparent,
                    hintText: "Input receiver's number..",
                    controller: _receiverPhoneNumberController,
                    onChanged: (value) {
                      receiverPhoneNumber = value;
                    },
                    contentPadding: 7,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Receiver's phone number.";
                      } else if (!isValidPhoneNumber(value)) {
                        return 'Please enter a valid Egyptian phone number.';
                      }
                      return null;
                    },
                    focusedBorderColor: const Color(0xff55433c),
                    enabledBorderColor: kPrimaryColor,
                    inputType: TextInputType.number,
                    prefixIcon: const Icon(Icons.phone),
                    obscureText: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
