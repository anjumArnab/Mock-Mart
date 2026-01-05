import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/theme/custom_theme_colors.dart';
import 'package:mock_mart/utils/dimensions.dart';

class CustomSearchBarWidget extends StatelessWidget {
  const CustomSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.searchBarPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<CustomThemeColors>()!.searchBarBackground,
        borderRadius: BorderRadius.circular(Dimensions.searchBarBorderRadius),
        border: Border.all(color: Theme.of(context).extension<CustomThemeColors>()!.inactiveColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "search_bar_text".tr,
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.fontSizeMedium,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.searchBarPadding,
                  vertical: Dimensions.paddingSizeDefault,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: Dimensions.searchBarIconSize,
              ),
              padding: EdgeInsets.all(Dimensions.searchBarIconPadding),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}