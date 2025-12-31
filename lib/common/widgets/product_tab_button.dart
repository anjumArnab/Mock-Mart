import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
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
              ? AppTheme.primaryColor
              : AppTheme.getInactiveColor(context),
          borderRadius: BorderRadius.circular(Dimensions.productTabBorderRadius),
        ),
        child: Text(
          text,
          style: productTabTextStyle.copyWith(
            color: isActive
                ? Colors.white
                : AppTheme.getSecondaryTextColor(context),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}