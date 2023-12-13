import 'package:flutter/material.dart';
import 'package:wheel_n_deal/constants.dart';

abstract class Styles {
  static const manropeExtraBold32 = TextStyle(
    fontSize: 32,
    fontFamily: kManropeExtraBold,
    fontWeight: FontWeight.w700,
  );
  static const manropeRegular12 = TextStyle(
    fontSize: 12,
    fontFamily: kManropeBold,
    fontWeight: FontWeight.w600,
  );
  static const manropeRegular15 = TextStyle(
    fontSize: 15,
    fontFamily: kManropeSemiBold,
    fontWeight: FontWeight.w500,
  );
  static const poppinsRegular = TextStyle(
    fontSize: 16,
    fontFamily: kPoppinsRegular,
    fontWeight: FontWeight.w500,
  );
  static const poppinsSemiBold16 = TextStyle(
    fontSize: 16,
    fontFamily: kPoppinsSemiBold,
    fontWeight: FontWeight.w600,
  );
}
