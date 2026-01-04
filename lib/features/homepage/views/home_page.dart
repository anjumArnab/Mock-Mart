import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/features/cart/cart_page.dart';
import 'package:mock_mart/features/categories/categories_page.dart';
import 'package:mock_mart/features/homepage/views/main_home_page.dart';
import 'package:mock_mart/features/menu/views/menu_page.dart';
import 'package:mock_mart/features/store/stores_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          const MainHomePage(),
          const CategoriesPage(),
          const CartPage(),
          const StoresPage(),
          MenuPage(),
        ],
      ),
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  Widget _buildCustomBottomNav() {
    return Container(
      height: Dimensions.bottomNavBarHeight,
      decoration: BoxDecoration(
        color: AppTheme.getBackgroundColor(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, "home".tr, 0, null),
          _buildNavItem(Icons.grid_view_rounded, "categories".tr, 1, null),
          _buildNavItem(Icons.shopping_bag_outlined, "cart".tr, 2, 6),
          _buildNavItem(Icons.store_outlined, "stores".tr, 3, null),
          _buildNavItem(Icons.menu, "menu".tr, 4, null),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, int? badgeCount) {
    bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.bottomNavBarPillPaddingHorizontal,
          vertical: Dimensions.bottomNavBarPillPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.bottomNavBarPillRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : AppTheme.getSecondaryTextColor(context),
                  size: Dimensions.bottomNavBarIconSize,
                ),
                if (badgeCount != null)
                  Positioned(
                    right: -8,
                    top: -8,
                    child: Badge.count(
                      backgroundColor: AppTheme.primaryColor,
                      count: badgeCount,
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