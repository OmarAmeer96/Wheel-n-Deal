import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/user/post_order/presentation/views/widgets/make_order_select_location_item.dart';

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

  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _senderNameController = TextEditingController();
  final _senderPhoneNumberController = TextEditingController();
  final _receiverPhoneNumberController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
        ],
      ),
    );
  }
}
