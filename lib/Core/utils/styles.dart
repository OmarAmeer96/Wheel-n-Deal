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
  // elsanteel modify
  static const manropeRegular16 = TextStyle(
    fontSize: 16,
    fontFamily: kManropeBold,
    fontWeight: FontWeight.w600,
  );

  static const manropeRegular15 = TextStyle(
    fontSize: 15,
    fontFamily: kManropeSemiBold,
    fontWeight: FontWeight.w500,
  );
  static const manropeMedium18 = TextStyle(
    fontSize: 18,
    fontFamily: kManropeMedium,
    fontWeight: FontWeight.w800,
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
  static const dMSansRegular = TextStyle(
    fontSize: 12,
    fontFamily: kDMSansRegular,
    fontWeight: FontWeight.w400,
    color: Color(0xFFA3A3A3),
    height: 0.50,
    letterSpacing: -0.40,
  );
  static const cairoRegular = TextStyle(
    fontSize: 15,
    fontFamily: kCairoRegular,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const cairoSemiBold = TextStyle(
    fontSize: 18,
    fontFamily: kCairoSemiBold,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
