import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/common/widgets/store_card.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class TopStores extends StatelessWidget {
  const TopStores({super.key});

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
                "top_stores".tr,
                style: sectionTitleTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "view_all".tr,
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
              itemBuilder: (context, index) => StoreCard(
                name: 'Morning Mart',
                rating: 4.5,
                products: '100 Products',
                reviews: '12 reviews',
              ),
            ),
          ),
        ],
      ),
    );
  }
}