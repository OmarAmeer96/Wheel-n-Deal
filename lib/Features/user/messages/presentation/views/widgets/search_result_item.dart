import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheel_n_deal/Core/utils/assets.dart';
import 'package:wheel_n_deal/Core/utils/styles.dart';

class SearchResultItem extends StatelessWidget {
  final String commuterName;

  const SearchResultItem({super.key, required this.commuterName});

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('h:mm a').format(DateTime.now());

    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 44,
                height: 44,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    AssetsData.profileImage,
                  ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Text(commuterName, style: Styles.manropeRegular14),
              const Spacer(),
              Text(
                formattedTime,
                style: Styles.manropeRegular14.copyWith(fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: Color(0xFFF3F3F3),
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
