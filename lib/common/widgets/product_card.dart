import 'package:flutter/material.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/images.dart';
import 'package:mock_mart/utils/text_styles.dart';

class ProductCard extends StatefulWidget {
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
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {

  late final AnimationController controller;
  late final Animation<double> scaleAnimation;
  late final Animation<double> opacityAnimation;

  bool isLiked = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.5).chain(
          CurveTween(curve: Curves.easeOutBack),
        ),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.5, end: 1.0).chain(
          CurveTween(curve: Curves.easeIn),
        ),
        weight: 30,
      ),
    ]).animate(controller);

    opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.3),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.3, end: 1.0),
        weight: 30,
      ),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void onIconTap() {
    if (controller.isAnimating) return;

    setState(() {
      isLiked = !isLiked;
    });

    controller.forward(from: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<CustomThemeColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: Dimensions.productCardImageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.productCardBorderRadius,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  Dimensions.productCardBorderRadius,
                ),
                child: Image.asset(
                  Images.productImg,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              bottom: Dimensions.productCardPadding,
              right: Dimensions.productCardPadding,
              child: GestureDetector(
                onTap: onIconTap,
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: scaleAnimation.value,
                      child: Opacity(
                        opacity: opacityAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                      Dimensions.productCardFavoriteIconPadding,
                    ),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: Dimensions.productCardFavoriteIconSize,
                      color: theme.negativeColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.all(Dimensions.productCardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: productTitleTextStyle.copyWith(
                  color: theme.textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Dimensions.productCardSpacing),
              Text(
                widget.price,
                style: productPriceTextStyle.copyWith(
                  color: theme.textColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.oldPrice,
                    style: discountedPriceTextStyle.copyWith(
                      color: theme.greyTextColor,
                    ),
                  ),
                  SizedBox(width: Dimensions.spacingSmall),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      Dimensions.discountBadgePaddingHorizontal,
                      vertical:
                      Dimensions.discountBadgePaddingVertical,
                    ),
                    decoration: BoxDecoration(
                      color: theme.negativeColor,
                      borderRadius: BorderRadius.circular(
                        Dimensions.discountBadgeBorderRadius,
                      ),
                    ),
                    child: Text(
                      widget.discount,
                      style: discountPercentageTextStyle.copyWith(
                        color:
                        Theme.of(context).colorScheme.error,
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