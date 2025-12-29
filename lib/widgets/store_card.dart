import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
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
      width: 200,
      height: 143,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppTheme.lightSubTitle,
        borderRadius: BorderRadius.circular(12),
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'assets/images/store_banner.png',
                  fit: BoxFit.cover,
                ),
              ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.lightNegative,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.store,
                        color: AppTheme.lightCardWhite,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: productTitleTextStyle
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppTheme.lightWarning,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                rating.toString(),
                                style: productTitleTextStyle
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          color: AppTheme.lightSuccess,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          products,
                          style: discountedPriceTextStyle.copyWith(
                            color: AppTheme.lightSuccess,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reviews,
                      style: discountedPriceTextStyle.copyWith(
                        color: AppTheme.lightSubTitle,
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
