import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/constants/text_styles.dart';
import 'package:mock_mart/constants/app_theme.dart';
import 'package:mock_mart/widgets/deal_product_card.dart';
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
    SizeConfig.init(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildNavTabs(),
            _buildSearchBar(),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildOneTimeDeal(),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildBigSaleBanner(),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildFeaturedProduct(),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildDealOfTheDay(),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildBanner('assets/images/banner.png'),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildNewUserExclusive(),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildTopStores(),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildBanner('assets/images/banner01.png'),
            SizedBox(height: SizeConfig.blockHeight * 2.5),
            _buildProductTabs(),
            SizedBox(height: SizeConfig.blockHeight * 5),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockWidth * 4),
      decoration: BoxDecoration(color: AppTheme.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, Welcome', style: helloWelcomeTextStyle),
              SizedBox(height: SizeConfig.blockHeight * 0.5),
              Text('Albert Stevano', style: userNameTextStyle),
            ],
          ),
          CircleAvatar(
            radius: SizeConfig.blockWidth * 6,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: AppTheme.primaryColor,
              size: SizeConfig.blockWidth * 6,
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
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.6),
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
      margin: EdgeInsets.all(SizeConfig.blockWidth * 4),
      decoration: BoxDecoration(
        color: AppTheme.getSearchBarBackground(context),
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 2),
        border: Border.all(
          color: AppTheme.getInactiveColor(context).withOpacity(0.3),
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
                  color: Colors.white.withOpacity(0.7),
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
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
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

  Widget _buildFeaturedProduct() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
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
          SizedBox(height: SizeConfig.blockHeight * 2),
          SizedBox(
            height: SizeConfig.blockHeight * 28,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: SizeConfig.blockWidth * 2.5),
              itemCount: 3,
              itemBuilder: (context, index) => ProductCard(
                title: 'Red Color Short Dress fo...',
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
        padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
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
                    SizedBox(width: SizeConfig.blockWidth * 2),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.bolt,
                          size: SizeConfig.blockWidth * 10,
                          color: AppTheme.secondaryColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockWidth * 2,
                            vertical: SizeConfig.blockHeight * 0.5,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.red,
                            borderRadius: BorderRadius.circular(
                              SizeConfig.blockWidth * 3,
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
                    horizontal: SizeConfig.blockWidth * 2.5,
                    vertical: SizeConfig.blockHeight * 0.75,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.blockWidth * 1.5,
                    ),
                    border: Border.all(
                      color: AppTheme.getInactiveColor(
                        context,
                      ).withOpacity(0.3),
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
            SizedBox(height: SizeConfig.blockHeight * 2),
            SizedBox(
              height: SizeConfig.blockHeight * 27,
              child: /*ListView(
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
              ),*/ ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => ProductCard(
                  title: 'Blue Color Short Dr...',
                  price: '\$3237.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(width: SizeConfig.blockWidth * 2.5),
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
            height: SizeConfig.blockHeight * 22,
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
                    horizontal: SizeConfig.blockWidth * 1.25,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.blockWidth * 3,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.blockWidth * 3,
                    ),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: SizeConfig.blockHeight * 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselImages.asMap().entries.map((entry) {
            return Container(
              width: _currentCarouselIndex == entry.key
                  ? SizeConfig.blockWidth * 6
                  : SizeConfig.blockWidth * 2,
              height: SizeConfig.blockHeight * 1,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockWidth * 1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1),
                color: _currentCarouselIndex == entry.key
                    ? AppTheme.primaryColor
                    : AppTheme.getInactiveColor(context).withOpacity(0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDealOfTheDay() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getSectionBackground(context),
          borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.blockWidth * 2),
          child: Row(
            children: [
              Expanded(
                child: GradientCard(
                  title1: "Don't Miss",
                  title2: "Today's",
                  title3: "Deal",
                ),
              ),
              SizedBox(width: SizeConfig.blockWidth * 3),
              Expanded(
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
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
      height: SizeConfig.blockHeight * 17,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(SizeConfig.blockWidth * 3),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildNewUserExclusive() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
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
          SizedBox(height: SizeConfig.blockHeight * 1.5),
          SizedBox(
            height: SizeConfig.blockHeight * 27,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: SizeConfig.blockWidth * 2.5),
              itemCount: 3,
              itemBuilder: (context, index) => ProductCard(
                title: 'Red Color Short Dress fo...',
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
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
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
          SizedBox(height: SizeConfig.blockHeight * 1.5),
          SizedBox(
            height: SizeConfig.blockHeight * 27,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: SizeConfig.blockWidth * 2.5),
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
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockWidth * 4),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ProductTabButton(text: 'New Arrivals', isActive: true),
                SizedBox(width: SizeConfig.blockWidth * 3),
                ProductTabButton(text: 'Discounted Products', isActive: false),
                SizedBox(width: SizeConfig.blockWidth * 3),
                ProductTabButton(text: 'Top Products', isActive: false),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockHeight * 2),
          SizedBox(
            height: SizeConfig.blockHeight * 50,
            child: GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.horizontal,
              children: [
                ProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                ProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                ProductCard(
                  title: 'Red Color Short Dress fo...',
                  price: '\$323.87',
                  oldPrice: '\$1100',
                  discount: '-5%',
                ),
                ProductCard(
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
