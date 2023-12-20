import 'package:flutter/material.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Features/user/profile/views/widgets/user_profile_bottom_sheet_item.dart';

Future<dynamic> imagePickerBottomSheet(
  BuildContext context, {
  required dynamic Function()? onTap1,
  required dynamic Function()? onTap2,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
    ),
    context: context,
    builder: (context) {
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
              UserProfileBottomSheetItem(
                icon: AssetsData.takePhotoIcon,
                text: "Take photo",
                onTap: onTap1,
              ),
              const SizedBox(
                height: 4,
              ),
              UserProfileBottomSheetItem(
                icon: AssetsData.choosePhotoIcon,
                text: "Choose from library",
                onTap: onTap2,
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
