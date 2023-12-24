import 'package:flutter/widgets.dart';

class Responsive {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static TextScaler textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler;
  }
}
