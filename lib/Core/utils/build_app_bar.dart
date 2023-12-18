import 'package:flutter/material.dart';

AppBar buildAppBar(
    {String text = '', Function()? onPressed, TextStyle? textStyle}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
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
