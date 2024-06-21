import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/helpers/extensions.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

void setupErrorState(BuildContext context, String error) {
  context.pop();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 32,
      ),
      content: Text(
        error,
        textAlign: TextAlign.center,
        style: Styles.manropeBold32.copyWith(
          color: kPrimaryColor,
          fontSize: 15,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            'Got it',
            style: Styles.manropeBold32.copyWith(
              color: kPrimaryColor,
              fontSize: 15,
            ),
          ),
        ),
      ],
    ),
  );
}
