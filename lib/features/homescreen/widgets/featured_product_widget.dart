import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/common/widgets/product_card.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/helpers/discounted_price_calc.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart' show CustomThemeColors;
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class FeaturedProductWidget extends StatelessWidget{
  final ProductModel product;

  const FeaturedProductWidget({super.key, required this.product});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "featured_products".tr,
                style: sectionTitleTextStyle.copyWith(
                  color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                ),
              ),
              Text(
                "view_all".tr,
                style: viewAllTextStyle.copyWith(
                  color: Theme.of(context).extension<CustomThemeColors>()!.textColor,
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.sectionTitleSpacing),
          SizedBox(
            height: SizeConfig.blockHeight * 28,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: Dimensions.listViewSeparator),
              itemCount: 3,
              itemBuilder: (context, index) => ProductCard(
                title: product.title,
                price: product.price,
                oldPrice: '5'
                    .applyDiscount(product.price)
                    .toStringAsFixed(2),
                discount: '-${product.discountedPercentage}%',
              ),
            ),
          ),
        ],
      ),
    );
  }
}