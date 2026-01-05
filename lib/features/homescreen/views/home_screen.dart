import 'package:flutter/material.dart';
import 'package:mock_mart/features/homescreen/views/main_home_screen.dart';
import 'package:mock_mart/features/cart/cart_screen.dart';
import 'package:mock_mart/features/categories/categories_screen.dart';
import 'package:mock_mart/features/menu/views/menu_screen.dart';
import 'package:mock_mart/features/store/stores_screen.dart';
import '../widgets/custom_bottom_nav_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex.value);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _selectedIndex.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    _selectedIndex.value = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          const MainHomeScreen(),
          const CategoriesScreen(),
          const CartScreen(),
          const StoresScreen(),
          MenuScreen(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, index, child) {
          return CustomBottomNavBar(
            currentIndex: index,
            cartBadgeCount: 6,
            onTap: _onNavItemTapped,
          );
        },
      ),
    );
  }
}