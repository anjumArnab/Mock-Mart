// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mock_mart/constants/text_styles.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/widgets/deal_product_card.dart';
import 'package:mock_mart/widgets/exclusive_product_card.dart';
import 'package:mock_mart/widgets/featured_product_card.dart';
import 'package:mock_mart/widgets/gradient_card.dart';
import 'package:mock_mart/widgets/product_card.dart';
import 'package:mock_mart/widgets/product_tab_button.dart';
import 'package:mock_mart/widgets/store_card.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            _buildNavTabs(),

            _buildSearchBar(),
            const SizedBox(height: 20),

            _buildOneTimeDeal(),
            const SizedBox(height: 20),

            _buildBigSaleBanner(),
            const SizedBox(height: 20),

            _buildFeaturedProduct(),
            const SizedBox(height: 20),

            _buildDealOfTheDay(),
            const SizedBox(height: 20),

            _buildBanner('assets/images/banner.png'),
            const SizedBox(height: 20),

            _buildNewUserExclusive(),
            const SizedBox(height: 20),

            _buildTopStores(),
            const SizedBox(height: 20),

            _buildBanner('assets/images/banner01.png'),
            const SizedBox(height: 20),

            _buildProductTabs(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: AppTheme.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Welcome',
                style: helloWelcomeTextStyle.copyWith(
                  color: AppTheme.lightCardWhite,
                ),
              ),
              const SizedBox(height: 4),

              Text(
                'Albert Stevano',
                style: userNameTextStyle.copyWith(
                  color: AppTheme.lightCardWhite,
                ),
              ),
            ],
          ),

          CircleAvatar(
            radius: 24,
            backgroundColor: AppTheme.lightCardWhite,
            child: Icon(Icons.person, color: AppTheme.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTabs() {
    return Container(
      color: AppTheme.primaryColor,
      child: TabBar(
        controller: _tabController,
        //isScrollable: true,
        indicatorColor: AppTheme.lightSecondaryColor,
        indicatorWeight: 3,
        labelColor: AppTheme.lightCardWhite,
        unselectedLabelColor: AppTheme.lightCardWhite.withOpacity(0.6),
        labelStyle: tabBarTextStyle.copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: tabBarTextStyle,
        tabs: const [
          Tab(text: 'Explore'),
          Tab(text: 'Sports'),
          Tab(text: 'Women\'s'),
          Tab(text: 'Kids'),
          Tab(text: 'Wigs'),
          Tab(text: 'Electronics'),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightSubTitle,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.lightInactive.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
                hintStyle: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: AppTheme.lightCardWhite,
                size: 24,
              ),
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProduct() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Featured Products', style: sectionTitleTextStyle),

              Text('View All', style: viewAllTextStyle),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 270,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FeaturedProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),

                FeaturedProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),

                FeaturedProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
              ],

            )
          ),
        ],
      ),
    );
  }

  Widget _buildOneTimeDeal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('One Time Deal', style: sectionTitleTextStyle),
                  const SizedBox(width: 8),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.bolt, size: 40,color: AppTheme.lightSecondaryColor,),
                      Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.redTextColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Upto 20%',
                        style: discountPercentageTextStyle.copyWith(
                          color: AppTheme.lightCardWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ]
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppTheme.lightInactive.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Text('Ends in ', style: endsInLabelTextStyle),

                    Text('06:02:04:08', style: endsInTimeTextStyle),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ProductCard(
                  title: 'Blue Color Short Dr...',
                  price: '\$3237.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),

                ProductCard(
                  title: 'Blue Color Short Dr...',
                  price: '\$3237.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),

                ProductCard(
                  title: 'Blue Color Short Dr...',
                  price: '\$3237.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigSaleBanner() {
    final List<String> carouselImages = [
      'assets/images/big_sale.png',
      'assets/images/big_sale.png',
      'assets/images/big_sale.png',
    ];

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
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
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselImages.asMap().entries.map((entry) {
            return Container(
              width: _currentCarouselIndex == entry.key ? 24.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentCarouselIndex == entry.key
                    ? AppTheme.primaryColor
                    : AppTheme.lightInactive.withOpacity(0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDealOfTheDay() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(color: AppTheme.lightInactive),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GradientCard(
                  title1: "Don't Miss",
                  title2: "Today's",
                  title3: "Deal",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: DealProductCard(
                  icon: Icons.watch,
                  iconColor: Colors.brown.shade700,
                  title: 'Red Color Short Dress for Girls...',
                  price: 323.87,
                  rating: 4.5,
                  reviews: 12,
                  discountColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildNewUserExclusive() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New User Exclusive', style: sectionTitleTextStyle),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View all',
                  style: viewAllTextStyle
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ExclusiveProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                  bgColor: Colors.amber.shade100,
                ),

                ExclusiveProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                  badge: 'Sale',
                  bgColor: Colors.amber.shade200,
                ),

                ExclusiveProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                  bgColor: Colors.amber.shade100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStores() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Stores', style: sectionTitleTextStyle),

              TextButton(
                onPressed: () {},
                child: Text(
                  'View all',
                  style: viewAllTextStyle
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                StoreCard(
                  name: 'Morning Mart',
                  rating: 4.5,
                  products: '100 Products',
                  reviews: '12 reviews',
                ),

                StoreCard(
                  name: 'Morning Mart',
                  rating: 4.5,
                  products: '100 Products',
                  reviews: '12 reviews',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ProductTabButton(text: 'New Arrivals', isActive: true),
                const SizedBox(width: 12),

                ProductTabButton(text: 'Discounted Products', isActive: false),
                const SizedBox(width: 12),

                ProductTabButton(text: 'Top Products', isActive: false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 400,
            child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,

              ),
              scrollDirection: Axis.horizontal,
              children: [
                FeaturedProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%'
                ),

                FeaturedProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),

                FeaturedProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),

                FeaturedProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
