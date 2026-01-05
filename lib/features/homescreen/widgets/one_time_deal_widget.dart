import 'package:flutter/material.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/common/widgets/product_card.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/helpers/discounted_price_calc.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class OneTimeDealWidget extends StatelessWidget{
  final ProductModel product;

  const OneTimeDealWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppTheme.getSectionBackground(context)),
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
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                    SizedBox(width: Dimensions.spacingSmall),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bolt,
                          size: Dimensions.dealIconSize,
                          color: AppTheme.secondaryColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.dealBadgePaddingHorizontal,
                            vertical: Dimensions.dealBadgePaddingVertical,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.red,
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
                      color: AppTheme.getInactiveColor(context),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Ends in ',
                        style: endsInLabelTextStyle.copyWith(
                          color: AppTheme.getTextColor(context),
                        ),
                      ),
                      Text(
                        '06:02:04:08',
                        style: endsInTimeTextStyle.copyWith(
                          color: AppTheme.getTextColor(context),
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