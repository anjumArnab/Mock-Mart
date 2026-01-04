import 'package:flutter/material.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.height = 56,
    this.width = double.infinity,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = Dimensions.radiusDefault,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.primaryColor,
          foregroundColor: foregroundColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          elevation: 0,
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                height: SizeConfig.blockWidth * .2,
                width: SizeConfig.blockWidth * .2,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    foregroundColor ?? Colors.white,
                  ),
                ),
              )
            : Text(
                text,
                style: interSemiBold
              ),
      ),
    );
  }
}