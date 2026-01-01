class Images {
  static String get banner => 'banner'.png;
  static String get banner01 => 'banner01'.png;
  static String get storeBanner => 'store_banner'.png;
  static String get bigSale => 'big_sale'.png;
  static String get productImg => 'product_img'.png;
  static String get todayDealBanner => 'today_deal_banner'.png;
}

extension on String {
  String get png => 'assets/images/$this.png';
}
