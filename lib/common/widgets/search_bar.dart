import 'package:flutter/material.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSearch;

  const SearchBar({
    super.key,
    this.controller,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.searchBarPadding),
      decoration: BoxDecoration(
        color: AppTheme.getSearchBarBackground(context),
        borderRadius: BorderRadius.circular(Dimensions.searchBarBorderRadius),
        border: Border.all(
          color: AppTheme.getInactiveColor(context),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: searchBarTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
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
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            child: IconButton(
              onPressed: onSearch,
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