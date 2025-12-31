import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/text_styles.dart';
import 'package:mock_mart/common/widgets/deal_product_card.dart';
import 'package:mock_mart/common/widgets/gradient_card.dart';
import 'package:mock_mart/common/widgets/product_card.dart';
import 'package:mock_mart/common/widgets/product_tab_button.dart';
import 'package:mock_mart/common/widgets/store_card.dart';

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
    SizeConfig.init(context);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildNavTabs()),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(_buildSearchBar()),
          ),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildOneTimeDeal()),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildBigSaleBanner()),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildFeaturedProduct()),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildDealOfTheDay()),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildBanner('assets/images/banner.png')),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildNewUserExclusive()),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildTopStores()),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildBanner('assets/images/banner01.png')),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: _buildProductTabs()),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.spacingLarge)),
          SliverToBoxAdapter(child: SizedBox(height: Dimensions.scrollBottomPadding)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(Dimensions.headerPadding),
      decoration: BoxDecoration(color: AppTheme.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, Welcome', style: helloWelcomeTextStyle),
              SizedBox(height: Dimensions.headerSpacing),
              Text('Albert Stevano', style: userNameTextStyle),
            ],
          ),
          CircleAvatar(
            radius: Dimensions.headerAvatarRadius,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: AppTheme.primaryColor,
              size: Dimensions.headerAvatarIconSize,
            ),
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
        indicatorColor: AppTheme.secondaryColor,
        indicatorWeight: Dimensions.tabBarIndicatorWeight,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
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
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'What are you looking for?',
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
              color: AppTheme.primaryColor,
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

  Widget _buildFeaturedProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Products',
                style: sectionTitleTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
              ),
              Text(
                'View All',
                style: viewAllTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.sectionTitleSpacing),
          SizedBox(
            height: SizeConfig.blockHeight * 28,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: Dimensions.listViewSeparator),
              itemCount: 3,
              itemBuilder: (context, index) => ProductCard(
                title: 'Red Color Short Dress for Girls',
                price: '\$323.87',
                oldPrice: '\$1100',
                discount: '-5%',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOneTimeDeal() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppTheme.getSectionBackground(context)),
      child: Padding(
        padding: EdgeInsets.all(Dimensions.sectionBackgroundPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'One Time Deal',
                      style: sectionTitleTextStyle.copyWith(
                        color: AppTheme.getTextColor(context),
                      ),
                    ),
                    SizedBox(width: Dimensions.spacingSmall),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bolt,
                          size: Dimensions.dealIconSize,
                          color: AppTheme.secondaryColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.dealBadgePaddingHorizontal,
                            vertical: Dimensions.dealBadgePaddingVertical,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.red,
                            borderRadius: BorderRadius.circular(
                              Dimensions.dealBadgeBorderRadius,
                            ),
                          ),
                          child: Text(
                            'Upto 20%',
                            style: discountPercentageTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.timerBadgePaddingHorizontal,
                    vertical: Dimensions.timerBadgePaddingVertical,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Dimensions.timerBadgeBorderRadius,
                    ),
                    border: Border.all(
                      color: AppTheme.getInactiveColor(context),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Ends in ',
                        style: endsInLabelTextStyle.copyWith(
                          color: AppTheme.getTextColor(context),
                        ),
                      ),
                      Text(
                        '06:02:04:08',
                        style: endsInTimeTextStyle.copyWith(
                          color: AppTheme.getTextColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.sectionTitleSpacing),
            SizedBox(
              height: SizeConfig.blockHeight * 27,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ProductCard(
                  title: 'Blue Color Short Dress for boys',
                  price: '\$3237.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: Dimensions.listViewSeparator),
                itemCount: 3,
              ),
            ),
          ],
        ),
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
                borderRadius: BorderRadius.circular(Dimensions.carouselIndicatorBorderRadius),
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

  Widget _buildDealOfTheDay() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getSectionBackground(context),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.dealSectionPadding),
          child: Row(
            children: [
              Expanded(
                child: GradientCard(
                  title1: "Don't Miss",
                  title2: "Today's",
                  title3: "Deal",
                ),
              ),
              SizedBox(width: Dimensions.spacingDefault),
              Expanded(
                child: DealProductCard(
                  icon: Icons.watch,
                  iconColor: Colors.brown.shade700,
                  title: 'Red Color Short Dress for Girls',
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
      margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      height: Dimensions.bannerHeightSmall,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(Dimensions.bannerBorderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.bannerBorderRadius),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildNewUserExclusive() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New User Exclusive',
                style: sectionTitleTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View all',
                  style: viewAllTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.sectionTitleSpacing),
          SizedBox(
            height: SizeConfig.blockHeight * 27,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: Dimensions.listViewSeparator),
              itemCount: 3,
              itemBuilder: (context, index) => ProductCard(
                title: 'Red Color Short Dress for Girls',
                price: '\$323.87',
                oldPrice: '\$1100',
                discount: '-5%',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStores() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Stores',
                style: sectionTitleTextStyle.copyWith(
                  color: AppTheme.getTextColor(context),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View all',
                  style: viewAllTextStyle.copyWith(
                    color: AppTheme.getTextColor(context),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.sectionTitleSpacing),
          SizedBox(
            height: SizeConfig.blockHeight * 27,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: Dimensions.listViewSeparator),
              itemCount: 3,
              itemBuilder: (context, index) => StoreCard(
                name: 'Morning Mart',
                rating: 4.5,
                products: '100 Products',
                reviews: '12 reviews',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ProductTabButton(text: 'New Arrivals', isActive: true),
                SizedBox(width: Dimensions.spacingDefault),
                ProductTabButton(text: 'Discounted Products', isActive: false),
                SizedBox(width: Dimensions.spacingDefault),
                ProductTabButton(text: 'Top Products', isActive: false),
              ],
            ),
          ),
          SizedBox(height: Dimensions.sectionTitleSpacing),
          SizedBox(
            height: Dimensions.gridViewHeight,
            child: GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Dimensions.gridViewCrossAxisCount.toInt(),
              ),
              scrollDirection: Axis.horizontal,
              children: [
                ProductCard(
                  title: 'Red Color Short Dress for Girls',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                ProductCard(
                  title: 'Red Color Short Dress for Girls',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                ProductCard(
                  title: 'Red Color Short Dress for Girls',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                ProductCard(
                  title: 'Red Color Short Dress for Girls',
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

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchBarDelegate(this.child);

  @override
  double get minExtent => Dimensions.persistentHeaderHeight;

  @override
  double get maxExtent => Dimensions.persistentHeaderHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_) => false;
}