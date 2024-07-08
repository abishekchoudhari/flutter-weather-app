import 'package:flutter/material.dart';

class SizeConfig {
  static late double textSizeSmall;
  static late double textSizeMedium;
  static late double textSizeLarge;
  static late double textSizeExtraLarge;
  static late double textSizeDoubleExtraLarge;
  static late double textSizeVeryLarge;

  static late double iconSizeSmall;
  static late double iconSizeMedium;
  static late double iconSizeLarge;
  static late double iconSizeExtraLarge;
  static late double iconSizeVeryLarge;
  static late double iconSizeVeryExtraLarge;

  static void init(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Assuming a tablet has a screen width of more than 600 pixels
    if (screenWidth > 600) {
      // Tablet sizes
      textSizeSmall = 18.0;
      textSizeMedium = 24.0;
      textSizeLarge = 30.0;
      textSizeExtraLarge = 36.0;
      textSizeDoubleExtraLarge = 72.0;
      textSizeVeryLarge = 96.0;

      iconSizeSmall = 24.0;
      iconSizeMedium = 30.0;
      iconSizeLarge = 36.0;
      iconSizeExtraLarge = 42.0;
      iconSizeVeryLarge = 66.0;
      iconSizeVeryExtraLarge = 200.0;
    } else {
      // Mobile sizes
      textSizeSmall = 14.0;
      textSizeMedium = 16.0;
      textSizeLarge = 22.0;
      textSizeExtraLarge = 28.0;
      textSizeDoubleExtraLarge = 50.0;
      textSizeVeryLarge = 72.0;

      iconSizeSmall = 18.0;
      iconSizeMedium = 24.0;
      iconSizeLarge = 30.0;
      iconSizeExtraLarge = 36.0;
      iconSizeVeryLarge = 48.0;
      iconSizeVeryExtraLarge = 100.0;
    }
  }
}
