// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/constants/text_styles.dart';

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
      margin: EdgeInsets.all(SizeConfig.blockWidth * 4),
      decoration: BoxDecoration(
        color: AppTheme.lightSubTitle,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
        border: Border.all(
          color: AppTheme.lightInactive.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: searchBarTextStyle.copyWith(
                color: AppTheme.lightTextColor,
              ),
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(
                  color: AppTheme.lightInactive,
                  fontSize: SizeConfig.blockWidth * 4,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockWidth * 4,
                  vertical: SizeConfig.blockHeight * 2,
                ),
              ),
            ),
          ),
          
          Container(
            margin: EdgeInsets.all(SizeConfig.blockWidth * 1),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1.5),
            ),
            child: IconButton(
              onPressed: onSearch,
              icon: Icon(
                Icons.search,
                color: AppTheme.lightCardWhite,
                size: SizeConfig.blockWidth * 6,
              ),
              padding: EdgeInsets.all(SizeConfig.blockWidth * 3),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}