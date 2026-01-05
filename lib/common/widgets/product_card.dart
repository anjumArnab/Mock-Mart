import 'package:flutter/material.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/images.dart';
import 'package:mock_mart/utils/text_styles.dart';


class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String oldPrice;
  final String discount;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: Dimensions.productCardImageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.productCardBorderRadius),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.productCardBorderRadius),
                child: Image.asset(
                  Images.productImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: Dimensions.productCardPadding,
              right: Dimensions.productCardPadding,
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
          padding: EdgeInsets.all(Dimensions.productCardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: productTitleTextStyle.copyWith(
                  color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Dimensions.productCardSpacing),
              Text(
                price,
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
                      borderRadius: BorderRadius.circular(Dimensions.discountBadgeBorderRadius),
                    ),
                    child: Text(
                      discount,
                      style: discountPercentageTextStyle.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}