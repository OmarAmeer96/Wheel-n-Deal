import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class MakeOrderSelectLocationItem extends StatelessWidget {
  const MakeOrderSelectLocationItem({
    super.key,
    required this.text,
    required this.onPressed,
    this.addressController,
  });

  final String text;
  final void Function()? onPressed;
  final TextEditingController? addressController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            text,
            style: Styles.cairoSemiBold.copyWith(
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Container(
            height: 30,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Text(/* addressController.text ?? */ "Select New Address"),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
