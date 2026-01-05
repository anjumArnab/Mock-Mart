import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int? cartBadgeCount;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartBadgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.bottomNavBarHeight,
      decoration: BoxDecoration(
        color: AppTheme.getBackgroundColor(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavItem(
            icon: Icons.home,
            label: "home".tr,
            index: 0,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          BottomNavItem(
            icon: Icons.grid_view_rounded,
            label: "categories".tr,
            index: 1,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          BottomNavItem(
            icon: Icons.shopping_bag_outlined,
            label: "cart".tr,
            index: 2,
            currentIndex: currentIndex,
            onTap: onTap,
            badgeCount: cartBadgeCount,
          ),
          BottomNavItem(
            icon: Icons.store_outlined,
            label: "stores".tr,
            index: 3,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          BottomNavItem(
            icon: Icons.menu,
            label: "menu".tr,
            index: 4,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int? badgeCount;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.bottomNavBarPillPaddingHorizontal,
          vertical: Dimensions.bottomNavBarPillPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius:
          BorderRadius.circular(Dimensions.bottomNavBarPillRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  size: Dimensions.bottomNavBarIconSize,
                  color: isSelected
                      ? Colors.white
                      : AppTheme.getSecondaryTextColor(context),
                ),
                if (badgeCount != null && badgeCount! > 0)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Badge.count(
                      backgroundColor: AppTheme.primaryColor,
                      count: badgeCount!,
                    ),
                  ),
              ],
            ),
            if (isSelected) ...[
              SizedBox(width: Dimensions.spacingSmall),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.fontSizeLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
