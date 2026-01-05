import 'package:flutter/material.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

import '../../utils/images.dart';

class DealProductCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String price;
  final double rating;
  final String oldPrice;
  final String discount;
  final int reviews;
  final Color discountColor;

  const DealProductCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
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
                child: Image.asset(Images.productImg, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: Dimensions.dealCardPadding,
                right: Dimensions.dealCardPadding,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.productCardFavoriteIconPadding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).extension<CustomThemeColors>()!.cardColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    size: Dimensions.productCardFavoriteIconSize,
                    color: Theme.of(context).extension<CustomThemeColors>()!.negativeColor,
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
                        color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
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
                    color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                  ),
                ),
                Text(
                  '\$$price',
                  style: productPriceTextStyle.copyWith(
                    color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      oldPrice,
                      style: discountedPriceTextStyle.copyWith(
                        color: Theme.of(context).extension<CustomThemeColors>()!.greyTextColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.spacingSmall),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.discountBadgePaddingHorizontal,
                        vertical: Dimensions.discountBadgePaddingVertical,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).extension<CustomThemeColors>()!.negativeColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.discountBadgeBorderRadius,
                        ),
                      ),
                      child: Text(
                        discount,
                        style: discountPercentageTextStyle.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(
                          Dimensions.radiusSmall,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
