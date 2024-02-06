import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/widgets/custom_main_button.dart';
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
                const Spacer(),
                CustomMainButton(
                  text: "Add Card",
                  onPressed: () {},
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
