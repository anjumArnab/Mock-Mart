import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/common/widgets/product_card.dart';
import 'package:mock_mart/common/widgets/product_tab_button.dart';
import 'package:mock_mart/helpers/discounted_price_calc.dart';
import 'package:mock_mart/utils/dimensions.dart';

class ProductTab extends StatefulWidget {
  final ProductModel product;
  final List<ProductModel> products;

  const ProductTab({
    super.key,
    required this.product,
    required this.products,
  });

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<ProductModel> _getProductsForTab(int tabIndex) {
    switch (tabIndex) {
      case 0: // New Arrivals
        return widget.products;
      case 1: // Discounted Products
        return widget.products
    .where((p) {
      final discount =
          double.tryParse(p.discountedPercentage ?? '0') ?? 0;
      return discount > 0;
    })
    .toList();
      case 2: // Top Products
        return widget.products;
      default:
        return widget.products;
    }
  }
  int _selectedProductTab = 0;

  @override
  Widget build(BuildContext context) {

    //int _selectedProductTab =0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelPadding: EdgeInsets.symmetric(horizontal: Dimensions.spacingDefault),
           // indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            tabs: [
            //  Tab(text: "cat_new_arrival".tr),


              Tab(child: ProductTabButton(text: "cat_new_arrival".tr,onTap: () {
                  setState(() {
                    _selectedProductTab = 0;
                  });
                },
                isActive: _selectedProductTab == 0,)),


             // Tab(text: "cat_discounted_products".tr),

Tab(child: ProductTabButton(text: "cat_discounted_products".tr,onTap: () {
                  setState(() {
                    _selectedProductTab = 1;
                  });
                },
                isActive: _selectedProductTab == 1,)),

             // Tab(text: "cat_top_products".tr),


              Tab(child: ProductTabButton(text: "cat_top_products".tr,onTap: () {
                  setState(() {
                    _selectedProductTab = 2;
                  });
                },
                isActive: _selectedProductTab == 2,)),
            ],
          ),
          SizedBox(height: Dimensions.sectionTitleSpacing),
          SizedBox(
            height: Dimensions.gridViewHeight,
            child: TabBarView(
              controller: _tabController,
              children: List.generate(3, (tabIndex) {
                List<ProductModel> displayProducts = _getProductsForTab(tabIndex);
                
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: Dimensions.gridViewCrossAxisCount.toInt(),
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: displayProducts.length,
                  itemBuilder: (context, index) {
                    final currentProduct = displayProducts[index];
                    return ProductCard(
                      title: currentProduct.title,
                      price: currentProduct.price,
                      oldPrice: currentProduct.price
                          .applyDiscount(currentProduct.price)
                          .toStringAsFixed(2),
                      discount: currentProduct.discountedPercentage != null
                          ? '-${currentProduct.discountedPercentage}%'
                          : '',
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}