import 'package:flutter/material.dart';
import 'package:hypertrip/theme/color.dart';

/// Button styles
const Size defaultButtonSize = Size(double.infinity, 50);
const double defaultButtonBorderRadius = 14;
const EdgeInsets defaultButtonPadding = EdgeInsets.zero;

/// Button rounded styles
final double defaultButtonBorderRounded = defaultButtonSize.height / 2;
final RoundedRectangleBorder defaultButtonRoundedShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(defaultButtonBorderRounded),
  ),
);

/// Card
const double defaultCardBorderRadius = 14;
final RoundedRectangleBorder defaultCardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(defaultCardBorderRadius),
);

/// Theme
ThemeData themeData(BuildContext context) => ThemeData(
      fontFamily: "Nunito",
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.textColor,
            displayColor: AppColors.textColor,
          ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.textGreyColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: defaultButtonPadding,
          minimumSize: defaultButtonSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultButtonBorderRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: defaultButtonPadding,
          minimumSize: defaultButtonSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultButtonBorderRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: defaultButtonPadding,
          minimumSize: defaultButtonSize,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultButtonBorderRadius),
          ),
        ),
      ),
      cardTheme: CardTheme(
        shape: defaultCardShape,
      ),

      /// ripple effect
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
