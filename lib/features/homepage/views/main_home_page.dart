import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/features/homepage/widgets/build_banner.dart';
import 'package:mock_mart/features/homepage/widgets/build_big_sale_banner.dart';
import 'package:mock_mart/features/homepage/widgets/custom_search_bar.dart';
import 'package:mock_mart/features/homepage/widgets/deal_of_today.dart';
import 'package:mock_mart/features/homepage/widgets/featured_product.dart';
import 'package:mock_mart/features/homepage/widgets/one_time_deal.dart';
import 'package:mock_mart/features/homepage/widgets/product_tab.dart';
import 'package:mock_mart/features/homepage/widgets/top_stores.dart';
import 'package:mock_mart/features/homepage/widgets/user_exclusive.dart';
import 'package:mock_mart/helpers/route_helper.dart';
import 'package:mock_mart/theme/app_theme.dart';
import 'package:mock_mart/utils/dimensions.dart';
import 'package:mock_mart/utils/gaps.dart';
import 'package:mock_mart/utils/text_styles.dart';

import '../../../utils/images.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
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
            delegate: _SearchBarDelegate(CustomSearchBar()),
          ),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: OneTimeDeal(product: products[0])),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: BuildBigSaleBanner()),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: FeaturedProduct(product: products[0])),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: DealOfToday(product: products[1])),

          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: BuildBanner(imagePath: Images.banner)),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: UserExclusive(product: products[2])),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),
          SliverToBoxAdapter(child: TopStores()),

          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverToBoxAdapter(child: BuildBanner(imagePath: Images.banner01)),
          SliverToBoxAdapter(
            child: Gaps.verticalGapOf(Dimensions.spacingLarge),
          ),

          SliverPersistentHeader(
            delegate: _ProductTabDelegate(
              ProductTab(product: products[0], products: products),
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
              Text("welcome_text".tr, style: helloWelcomeTextStyle),
              SizedBox(height: Dimensions.headerSpacing),
              Text("name".tr, style: userNameTextStyle),
            ],
          ),
          GestureDetector(
            onTap:() => Get.offAllNamed(RouteHelper.getUserProfilePageRoute()),
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
        tabs: [
          Tab(text: "tab01".tr),
          Tab(text: "tab02".tr),
          Tab(text: "tab03".tr),
          Tab(text: "tab04".tr),
          Tab(text: "tab05".tr),
          Tab(text: "tab06".tr),
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
