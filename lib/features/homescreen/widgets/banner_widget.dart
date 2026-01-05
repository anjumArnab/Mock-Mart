import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';

class BannerWidget extends StatelessWidget {
  final String imagePath;

  const BannerWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      height: Dimensions.bannerHeightSmall,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(Dimensions.bannerBorderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.bannerBorderRadius),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}