import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/constants/text_styles.dart';

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
      width: SizeConfig.blockWidth * 50,
      height: SizeConfig.blockHeight * 18,
      margin: EdgeInsets.only(right: SizeConfig.blockWidth * 3),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.blockHeight * 12.5,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(SizeConfig.blockWidth * 3),
              ),
              child: Image.asset(
                'assets/images/store_banner.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: SizeConfig.blockWidth * 10,
                      height: SizeConfig.blockWidth * 10,
                      decoration: BoxDecoration(
                        color: AppTheme.getNegativeColor(context),
                        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
                      ),
                      child: Icon(
                        Icons.store,
                        color: Colors.white,
                        size: SizeConfig.blockWidth * 6,
                      ),
                    ),
                    SizedBox(width: SizeConfig.blockWidth * 3),
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
                                size: SizeConfig.blockWidth * 3.5,
                              ),
                              SizedBox(width: SizeConfig.blockWidth * 1),
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
                SizedBox(height: SizeConfig.blockHeight * 1.5),
                Divider(color: AppTheme.getInactiveColor(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          color: AppTheme.success,
                          size: SizeConfig.blockWidth * 3.5,
                        ),
                        SizedBox(width: SizeConfig.blockWidth * 1),
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