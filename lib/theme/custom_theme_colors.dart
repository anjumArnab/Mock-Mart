import 'package:flutter/material.dart';

class CustomThemeColors extends ThemeExtension<CustomThemeColors> {
  final Color cardColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color inactiveColor;
  final Color sectionBackground;
  final Color searchBarBackground;
  final Color greyTextColor;
  final Color successColor;
  final Color negativeColor;

  const CustomThemeColors({
    required this.cardColor,
    required this.textColor,
    required this.secondaryTextColor,
    required this.inactiveColor,
    required this.sectionBackground,
    required this.searchBarBackground,
    required this.greyTextColor,
    required this.successColor,
    required this.negativeColor,
  });

  // Light theme
  factory CustomThemeColors.light() => const CustomThemeColors(
    cardColor: Color(0xFFFFFFFF),
    textColor: Color(0xFF000000),
    secondaryTextColor: Color(0xFF595959),
    inactiveColor: Color(0x1AAFAFAF),
    sectionBackground: Color(0xFFF3F6F8),
    searchBarBackground: Color(0xFFFCFCFC),
    greyTextColor: Color(0xFF808080),
    successColor: Colors.green,
    negativeColor: Color(0x99FF5555),
  );

  // Dark theme
  factory CustomThemeColors.dark() => const CustomThemeColors(
    cardColor: Color(0xFF1A1F2E),
    textColor: Color(0xFFFCFCFC),
    secondaryTextColor: Color(0xFFAFB1B5),
    inactiveColor: Color(0x1AE9F3FF),
    sectionBackground: Color(0x1AAFAFAF),
    searchBarBackground: Color(0xFF595959),
    greyTextColor: Color(0xFF808080),
    successColor: Colors.green,
    negativeColor: Color(0x99FF5555),
  );

  @override
  CustomThemeColors copyWith({
    Color? cardColor,
    Color? textColor,
    Color? secondaryTextColor,
    Color? inactiveColor,
    Color? sectionBackground,
    Color? searchBarBackground,
    Color? greyTextColor,
    Color? successColor,
    Color? negativeColor,
  }) {
    return CustomThemeColors(
      cardColor: cardColor ?? this.cardColor,
      textColor: textColor ?? this.textColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      sectionBackground: sectionBackground ?? this.sectionBackground,
      searchBarBackground: searchBarBackground ?? this.searchBarBackground,
      greyTextColor: greyTextColor ?? this.greyTextColor,
      successColor: successColor ?? this.successColor,
      negativeColor: negativeColor ?? this.negativeColor,
    );
  }

  @override
  CustomThemeColors lerp(ThemeExtension<CustomThemeColors>? other, double t) {
    if (other is! CustomThemeColors) return this;

    return CustomThemeColors(
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      secondaryTextColor: Color.lerp(
        secondaryTextColor,
        other.secondaryTextColor,
        t,
      )!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      sectionBackground: Color.lerp(
        sectionBackground,
        other.sectionBackground,
        t,
      )!,
      searchBarBackground: Color.lerp(
        searchBarBackground,
        other.searchBarBackground,
        t,
      )!,
      greyTextColor: Color.lerp(greyTextColor, other.greyTextColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      negativeColor: Color.lerp(negativeColor, other.negativeColor, t)!,
    );
  }
}
