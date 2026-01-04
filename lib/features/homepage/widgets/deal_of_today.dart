import 'package:flutter/material.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/common/widgets/deal_product_card.dart';
import 'package:mock_mart/common/widgets/gradient_card.dart';
import 'package:mock_mart/helpers/discounted_price_calc.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';

class DealOfToday extends StatelessWidget{
  final ProductModel product;

  const DealOfToday({super.key, required this.product});

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getSectionBackground(context),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.dealSectionPadding),
          child: Row(
            children: [
              Expanded(
                child: GradientCard(
                ),
              ),
              SizedBox(width: Dimensions.spacingDefault),
              Expanded(
                child: DealProductCard(
                  icon: Icons.watch,
                  iconColor: Colors.brown.shade700,
                  title: product.title,
                  price: product.price,
                  rating: 4.5,
                  reviews: 12,
                  discountColor: Colors.green,
                  oldPrice:'5'
                      .applyDiscount(product.price)
                      .toStringAsFixed(2),
                    discount: '-${product.discountedPercentage}%',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}