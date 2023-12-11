import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomMainButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: const Color(0xff8D070F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19),
        ),
      ),
      child: Container(
        width: 367,
        height: 67,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontFamily: "Gilroy-Reular",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
