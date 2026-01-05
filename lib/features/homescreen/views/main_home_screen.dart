import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/features/homescreen/widgets/banner_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/big_sale_banner_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/custom_search_bar_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/deal_of_today_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/featured_product_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/one_time_deal_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/product_tab_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/top_stores_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/user_exclusive_widget.dart';
import 'package:mock_mart/helpers/route_helper.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/gaps.dart';
import 'package:mock_mart/utils/images.dart';
import 'package:mock_mart/utils/text_styles.dart';


class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with SingleTickerProviderStateMixin {
  List<ProductModel> products = [
    ProductModel(
      title: 'Blue Color Short Dress for boys',
      image: Images.productImg,
      price: '\$3237.87',
      discountedPercentage: '5',
    ),
    ProductModel(
      title: 'Red Color Short Dress for Girls',
      image: Images.productImg,
      price: '\$323.87',
      discountedPercentage: '5',
    ),
    ProductModel(
      title: 'Red ',
      image: Images.productImg,
      price: '\$323.87',
      rating: '4.5',
      totalReviews: 12,
    ),
  ];

  late TabController _tabController;

  final List<String> _tabs = [
    "tab01",
    "tab02",
    "tab03",
    "tab04",
    "tab05",
    "tab06",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
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
          SliverAppBar(
            expandedHeight: Dimensions.expandedHeight,
            floating: false,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.all(Dimensions.headerPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("welcome_text".tr, style: helloWelcomeTextStyle),
                        SizedBox(height: Dimensions.headerSpacing),
                        Text("name".tr, style: userNameTextStyle),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Get.offAllNamed(
                        RouteHelper.getUserProfilePageRoute(),
                      ),
                      child: CircleAvatar(
                        radius: Dimensions.headerAvatarRadius,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: AppTheme.primaryColor,
                          size: Dimensions.headerAvatarIconSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.secondaryColor,
              indicatorWeight: Dimensions.tabBarIndicatorWeight,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              labelStyle: tabBarTextStyle.copyWith(fontWeight: FontWeight.bold),
              unselectedLabelStyle: tabBarTextStyle,
              tabs: [
                Tab(text: _tabs[0].tr),
                Tab(text: _tabs[1].tr),
                Tab(text: _tabs[2].tr),
                Tab(text: _tabs[3].tr),
                Tab(text: _tabs[4].tr),
                Tab(text: _tabs[5].tr),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(CustomSearchBarWidget()),
          ),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: OneTimeDealWidget(product: products[0])),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: BigSaleBannerWidget()),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: FeaturedProductWidget(product: products[0])),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: DealOfTodayWidget(product: products[1])),

          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: BannerWidget(imagePath: Images.banner)),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: UserExclusiveWidget(product: products[2])),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),
          SliverToBoxAdapter(child: TopStoresWidget()),

          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: BannerWidget(imagePath: Images.banner01)),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverPersistentHeader(
            delegate: _ProductTabDelegate(
              ProductTabWidget(product: products[0], products: products),
            ),
          ),

          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: Dimensions.scrollBottomPadding),
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
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_) => false;
}

class _ProductTabDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _ProductTabDelegate(this.child);

  @override
  double get minExtent => 650;

  @override
  double get maxExtent => 650;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_) => false;
}
