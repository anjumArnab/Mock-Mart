import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/constants/text_styles.dart';

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
          horizontal: SizeConfig.blockWidth * 4,
          vertical: SizeConfig.blockHeight * 1.25,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor : AppTheme.lightInactive,
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
        ),
        child: Text(
          text,
          style: productTabTextStyle.copyWith(
            color: isActive ? AppTheme.lightCardWhite : AppTheme.lightSubTitle,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
