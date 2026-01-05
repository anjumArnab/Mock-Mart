import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/images.dart';

class BigSaleBannerWidget extends StatefulWidget {
  const BigSaleBannerWidget({super.key});

  @override
  State<BigSaleBannerWidget> createState() => _BigSaleBannerWidgetState();
}

class _BigSaleBannerWidgetState extends State<BigSaleBannerWidget> {
  int _currentCarouselIndex = 0;
  
  final List<String> carouselImages = [
    Images.bigSale,
    Images.bigSale,
    Images.bigSale,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: Dimensions.carouselHeight,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
          ),
          items: carouselImages.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.carouselIndicatorMargin,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.carouselBorderRadius,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimensions.carouselBorderRadius,
                    ),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: Dimensions.spacingDefault),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselImages.asMap().entries.map((entry) {
            return Container(
              width: _currentCarouselIndex == entry.key
                  ? Dimensions.carouselIndicatorWidth
                  : Dimensions.carouselIndicatorWidthActive,
              height: Dimensions.carouselIndicatorHeight,
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.carouselIndicatorMargin,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.carouselIndicatorBorderRadius,
                ),
                color: _currentCarouselIndex == entry.key
                    ? AppTheme.primaryColor
                    : AppTheme.getInactiveColor(context),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}