import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

import '../../utils/images.dart';

class DealProductCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final double price;
  final double rating;
  final int reviews;
  final Color discountColor;

  const DealProductCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.discountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.dealCardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: Dimensions.dealCardImageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.dealCardBorderRadius),
                  ),
                ),
                child: Image.asset(
                  Images.productImg,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: Dimensions.dealCardPadding,
                right: Dimensions.dealCardPadding,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.productCardFavoriteIconPadding),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: Dimensions.productCardFavoriteIconSize,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.dealCardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: Dimensions.iconSizeExtraSmall,
                    ),
                    Text(
                      '$rating ($reviews Reviews)',
                      style: productTitleTextStyle.copyWith(
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                    SizedBox(width: Dimensions.spacingSmall),
                    Icon(
                      Icons.discount,
                      color: Colors.green,
                      size: Dimensions.iconSizeExtraSmall,
                    ),
                  ],
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: productPriceTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                Text(
                  '\$$price',
                  style: productPriceTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}