import 'package:flutter/material.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class ProductTabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const ProductTabButton({
    super.key,
    required this.text,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.productTabPaddingHorizontal,
          vertical: Dimensions.productTabPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).extension<CustomThemeColors>()!.inactiveColor,
          borderRadius: BorderRadius.circular(Dimensions.productTabBorderRadius),
        ),
        child: Text(
          text,
          style: productTabTextStyle.copyWith(
            color: isActive
                ? Colors.white
                : Theme.of(context).extension<CustomThemeColors>()!.secondaryTextColor,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}