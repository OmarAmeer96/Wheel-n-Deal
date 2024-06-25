import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/responsive.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';
import 'package:wheel_n_deal/constants.dart';

class PostTripFromSelectLocationItem extends StatelessWidget {
  const PostTripFromSelectLocationItem({
    super.key,
    required this.text,
    required this.onPressed,
    this.fromAddressController,
    this.fromSelectedAddress = "Select New Address",
  });

  final String text;
  final void Function()? onPressed;
  final TextEditingController? fromAddressController;
  final String fromSelectedAddress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Row(
        children: [
          Text(
            text,
            style: Styles.cairoSemiBold.copyWith(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              height: Responsive.screenHeight(context) * 0.03,
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
                  Expanded(
                    child: Text(
                      fromAddressController?.text ?? fromSelectedAddress,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
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
          ),
        ],
      ),
    );
  }
}
