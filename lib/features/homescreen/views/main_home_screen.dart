import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mock_mart/constants/size_config.dart';
import 'package:mock_mart/features/homescreen/controllers/product_controller.dart';
import 'package:mock_mart/features/homescreen/widgets/banner_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/big_sale_banner_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/custom_search_bar_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/deal_of_today_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/featured_product_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/profile_avatar_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/one_time_deal_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/product_tab_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/top_stores_widget.dart';
import 'package:mock_mart/features/homescreen/widgets/user_exclusive_widget.dart';
import 'package:mock_mart/features/profile/controllers/user_controller.dart';
import 'package:mock_mart/helpers/route_helper.dart';
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

    return GetBuilder<ProductController>(
      builder: (productController) {
        return GetBuilder<UserController>(
          builder: (userController) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: Dimensions.expandedHeight,
                    backgroundColor: Theme.of(context).colorScheme.primary,
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
                                Text(
                                  userController.profileModel?.fullName ?? "user_name".tr,
                                  style: userNameTextStyle,
                                ),
                              ],
                            ),
                            ProfileAvatarWidget(
                                onTap: ()=>Get.toNamed(
                                RouteHelper.getUserProfileScreenRoute(),
                              ),
                    localImage: userController.pickedFile != null
                        ? File(userController.pickedFile!.path)
                        : null,
                    networkImage: userController.profileModel!.imageUrl,
                  ),
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(
                      controller: _tabController,
                      indicatorColor: Theme.of(context).colorScheme.secondary,
                      indicatorWeight: Dimensions.tabBarIndicatorWeight,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      labelStyle: tabBarTextStyle.copyWith(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: tabBarTextStyle,
                      tabs: _tabs.map((t) => Tab(text: t.tr)).toList(),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SearchBarDelegate(CustomSearchBarWidget()),
                  ),

                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),

                  SliverToBoxAdapter(
                    child: OneTimeDealWidget(product: productController.products[0]),
                  ),

                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),
                  SliverToBoxAdapter(child: BigSaleBannerWidget()),
                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),

                  SliverToBoxAdapter(
                    child: FeaturedProductWidget(product: productController.products[0]),
                  ),

                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),

                  SliverToBoxAdapter(
                    child: DealOfTodayWidget(product: productController.products[1]),
                  ),

                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),
                  SliverToBoxAdapter(child: BannerWidget(imagePath: Images.banner)),
                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),

                  SliverToBoxAdapter(
                    child: UserExclusiveWidget(product: productController.products[2]),
                  ),

                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),
                  SliverToBoxAdapter(child: TopStoresWidget()),
                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),

                  SliverToBoxAdapter(child: BannerWidget(imagePath: Images.banner01)),
                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),

                  SliverPersistentHeader(
                    delegate: _ProductTabDelegate(
                      ProductTabWidget(
                        product: productController.products[0],
                        products: productController.products,
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(child: Gaps.verticalGapOf(Dimensions.spacingLarge)),
                  /// SliverToBoxAdapter(child: SizedBox(height: Dimensions.scrollBottomPadding)),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchBarDelegate(this.child);

  @override
  double get minExtent => Dimensions.persistentHeaderExtent;

  @override
  double get maxExtent => Dimensions.persistentHeaderExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_) => false;
}

class _ProductTabDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _ProductTabDelegate(this.child);

  @override
  double get minExtent => Dimensions.productTabExtent;

  @override
  double get maxExtent => Dimensions.productTabExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_) => false;
}
