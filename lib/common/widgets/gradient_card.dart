import 'package:flutter/material.dart';
import 'package:mock_mart/utils/dimensions.dart';

import '../../utils/images.dart';

class GradientCard extends StatelessWidget {
  const GradientCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.productCardBorderRadius),
        child: Image.asset(Images.todayDealBanner, fit: BoxFit.cover),

    );
  }
}
