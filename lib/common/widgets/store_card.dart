import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
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
        color: AppTheme.getCardColor(context),
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
                        color: AppTheme.getNegativeColor(context),
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
                              color: AppTheme.getTextColor(context),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppTheme.warning,
                                size: Dimensions.storeCardIconSize,
                              ),
                              SizedBox(width: Dimensions.spacingExtraSmall),
                              Text(
                                rating.toString(),
                                style: productTitleTextStyle.copyWith(
                                  color: AppTheme.getTextColor(context),
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
                Divider(color: AppTheme.getInactiveColor(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: AppTheme.success,
                          size: Dimensions.storeCardIconSize,
                        ),
                        SizedBox(width: Dimensions.spacingExtraSmall),
                        Text(
                          products,
                          style: discountedPriceTextStyle.copyWith(
                            color: AppTheme.success,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reviews,
                      style: discountedPriceTextStyle.copyWith(
                        color: AppTheme.getSecondaryTextColor(context),
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