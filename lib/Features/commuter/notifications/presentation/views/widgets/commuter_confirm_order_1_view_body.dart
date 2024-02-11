import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/Features/commuter/notifications/presentation/views/widgets/selected_by_item.dart';

class CommuterConfirmOrder1ViewBody extends StatelessWidget {
  const CommuterConfirmOrder1ViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 26,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "You have been selected by",
                  style: Styles.manropeRegular16.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 45,
              ),
              const SelectedByItem(
                name: 'Ahmed',
                phoneNumber: '01554111002',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
