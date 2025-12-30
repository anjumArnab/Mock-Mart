import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/constants/text_styles.dart';

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
              height: SizeConfig.blockHeight * 15,
             // width:  double.infinity, //SizeConfig.blockWidth * 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.blockWidth * 3),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
                child: Image.asset(
                  'assets/images/img.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: SizeConfig.blockHeight * 1,
              right: SizeConfig.blockWidth * 2,
              child: Container(
                padding: EdgeInsets.all(SizeConfig.blockWidth * 1.5),
                decoration: BoxDecoration(
                  color: AppTheme.getCardColor(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite_border,
                  size: SizeConfig.blockWidth * 4.5,
                  color: AppTheme.getNegativeColor(context),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: productTitleTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: SizeConfig.blockHeight * 0.5),
              Text(
                price,
                style: productPriceTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Row(
                children: [
                  Text(
                    oldPrice,
                    style: discountedPriceTextStyle.copyWith(
                      color: AppTheme.getGreyTextColor(context),
                    ),
                  ),
                  SizedBox(width: SizeConfig.blockWidth * 1),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockWidth * 1,
                      vertical: SizeConfig.blockHeight * 0.25,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.getNegativeColor(context),
                      borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1),
                    ),
                    child: Text(
                      discount,
                      style: discountPercentageTextStyle.copyWith(
                        color: AppTheme.red,
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