import 'package:flutter/material.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/views/cart_page.dart';
import 'package:mock_mart/views/categories_page.dart';
import 'package:mock_mart/views/main_home_page.dart';
import 'package:mock_mart/views/menu_page.dart';
import 'package:mock_mart/views/stores_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const HomePage({super.key, required this.onThemeToggle});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      const MainHomePage(),
      const CategoriesPage(),
      const CartPage(),
      const StoresPage(),
      MenuPage(onThemeToggle: widget.onThemeToggle),
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }

  Widget _buildCustomBottomNav() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.getBackgroundColor(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', 0, null),
          _buildNavItem(Icons.grid_view_rounded, 'Categories', 1, null),
          _buildNavItem(Icons.shopping_bag_outlined, 'Cart', 2, 6),
          _buildNavItem(Icons.store_outlined, 'Stores', 3, null),
          _buildNavItem(Icons.menu, 'Menu', 4, null),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index, int? badgeCount) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
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
                  size: 24,
                ),
                if (badgeCount != null)
                  Badge.count(
                    backgroundColor: AppTheme.primaryColor,
                    count: badgeCount,
                  ),
              ],
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
