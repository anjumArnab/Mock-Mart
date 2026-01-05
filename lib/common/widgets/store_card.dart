import 'package:flutter/material.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';
import '../../utils/images.dart';

class StoreCard extends StatelessWidget {
  final String name;
  final double rating;
  final String products;
  final String reviews;

  const StoreCard({
    super.key,
    required this.name,
    required this.rating,
    required this.products,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.storeCardWidth,
      height: Dimensions.storeCardHeight,
      margin: EdgeInsets.only(right: Dimensions.spacingDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomThemeColors>()!.cardColor,
        borderRadius: BorderRadius.circular(Dimensions.storeCardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Dimensions.storeCardBannerHeight,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Dimensions.storeCardBorderRadius),
              ),
              child: Image.asset(
                Images.storeBanner,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Dimensions.storeCardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: Dimensions.storeCardLogoSize,
                      height: Dimensions.storeCardLogoSize,
                      decoration: BoxDecoration(
                        color: Theme.of(context).extension<CustomThemeColors>()!.negativeColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      ),
                      child: Icon(
                        Icons.store,
                        color: Colors.white,
                        size: Dimensions.iconSizeDefault,
                      ),
                    ),
                    SizedBox(width: Dimensions.spacingDefault),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: productTitleTextStyle.copyWith(
                              color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Theme.of(context).colorScheme.secondary,
                                size: Dimensions.storeCardIconSize,
                              ),
                              SizedBox(width: Dimensions.spacingExtraSmall),
                              Text(
                                rating.toString(),
                                style: productTitleTextStyle.copyWith(
                                  color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.spacingDefault),
                Divider(color: Theme.of(context).extension<CustomThemeColors>()!.inactiveColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: Theme.of(context).extension<CustomThemeColors>()!.successColor,
                          size: Dimensions.storeCardIconSize,
                        ),
                        SizedBox(width: Dimensions.spacingExtraSmall),
                        Text(
                          products,
                          style: discountedPriceTextStyle.copyWith(
                            color: Theme.of(context).extension<CustomThemeColors>()!.successColor,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reviews,
                      style: discountedPriceTextStyle.copyWith(
                        color: Theme.of(context).extension<CustomThemeColors>()!.secondaryTextColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
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