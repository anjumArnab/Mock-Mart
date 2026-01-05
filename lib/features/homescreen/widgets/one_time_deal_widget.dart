import 'package:flutter/material.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/common/widgets/product_card.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/helpers/discounted_price_calc.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class OneTimeDealWidget extends StatelessWidget{
  final ProductModel product;

  const OneTimeDealWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Theme.of(context).extension<CustomThemeColors>()!.sectionBackground),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.sectionBackgroundPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'One Time Deal',
                      style: sectionTitleTextStyle.copyWith(
                        color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.spacingSmall),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bolt,
                          size: Dimensions.dealIconSize,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.dealBadgePaddingHorizontal,
                            vertical: Dimensions.dealBadgePaddingVertical,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error,
                            borderRadius: BorderRadius.circular(
                              Dimensions.dealBadgeBorderRadius,
                            ),
                          ),
                          child: Text(
                            'Upto 20%',
                            style: discountPercentageTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.timerBadgePaddingHorizontal,
                    vertical: Dimensions.timerBadgePaddingVertical,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.timerBadgeBorderRadius,
                    ),
                    border: Border.all(
                      color: Theme.of(context).extension<CustomThemeColors>()!.inactiveColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Ends in ',
                        style: endsInLabelTextStyle.copyWith(
                          color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                        ),
                      ),
                      Text(
                        '06:02:04:08',
                        style: endsInTimeTextStyle.copyWith(
                          color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.sectionTitleSpacing),
            SizedBox(
              height: SizeConfig.blockHeight * 27,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ProductCard(
                  title: product.title,
                  price: product.price,
                  oldPrice: '5'
                      .applyDiscount(product.price)
                      .toStringAsFixed(2),
                  discount: '-${product.discountedPercentage}%',
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: Dimensions.listViewSeparator),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}