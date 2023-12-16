import 'package:flutter/material.dart';

// elsanteel modify adding optional text style variable
AppBar buildAppBar(
    {String text = '', Function()? onPressed, TextStyle? textStyle}) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 26,
      ),
      onPressed: () {
        onPressed?.call();
      },
    ),
    title: Text(
      text,
      style: textStyle,
    ),
    centerTitle: true,
  );
}
