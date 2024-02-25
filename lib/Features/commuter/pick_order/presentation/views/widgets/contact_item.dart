import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(500),
      onTap: () {},
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffd8d8d8),
            borderRadius: BorderRadius.circular(500),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xffd8d8d8),
              radius: 15,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SvgPicture.asset(
                    icon,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
