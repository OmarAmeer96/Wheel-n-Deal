import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

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

  final _fromController = TextEditingController();

  final _toController = TextEditingController();

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
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
