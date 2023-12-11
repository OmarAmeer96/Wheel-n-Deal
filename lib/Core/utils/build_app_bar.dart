import 'package:flutter/material.dart';

AppBar buildAppBar({String text = ''}) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 26,
      ),
      onPressed: () {},
    ),
    title: Text(text),
    centerTitle: true,
  );
}
