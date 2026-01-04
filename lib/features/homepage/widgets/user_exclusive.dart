import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/common/widgets/product_card.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/helpers/discounted_price_calc.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class UserExclusive extends StatelessWidget {
  final ProductModel product;
  const UserExclusive({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               "new_user_exclusive".tr,
                style: sectionTitleTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'view_all'.tr,
                  style: viewAllTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.sectionTitleSpacing),
          SizedBox(
            height: SizeConfig.blockHeight * 27,
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