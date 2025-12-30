import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/constants/text_styles.dart';

class DealProductCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final double price;
  final double rating;
  final int reviews;
  final Color discountColor;

  const DealProductCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.discountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: SizeConfig.blockWidth * 2,
            offset: Offset(0, SizeConfig.blockHeight * 0.25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: SizeConfig.blockHeight * 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockWidth * 3),
                  ),
                ),
                child: Image.asset(
                  'assets/images/img.png',
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                bottom: SizeConfig.blockHeight * 1,
                right: SizeConfig.blockWidth * 2,
                child: Container(
                  padding: EdgeInsets.all(SizeConfig.blockWidth * 1.5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: SizeConfig.blockWidth * 4.5,
                    color: Colors.red,
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
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: SizeConfig.blockWidth * 4,
                    ),

                    Text(
                      '$rating ($reviews Reviews)',
                      style: productTitleTextStyle.copyWith(
                        color: AppTheme.getTextColor(context),
                      ),
                    ),

                    SizedBox(width: SizeConfig.blockWidth * 2),
                    Icon(
                      Icons.discount,
                      color: Colors.green,
                      size: SizeConfig.blockWidth * 4,
                    ),
                  ],
                ),

                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: productPriceTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                  ),
                ),

                Text(
                  '\$price',
                  style: productPriceTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}