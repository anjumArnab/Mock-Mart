class ProductModel {
  String title;
  String image;
  String price;
  String? discountedPercentage;
  String? rating;
  int? totalReviews;
  int? inStock;
  bool? isNew;
  bool? isBestSelling;
  bool? isFav;

  ProductModel({
    required this.title,
    required this.image,
    required this.price,
    this.discountedPercentage,
    this.rating,
    this.totalReviews,
    this.inStock,
    this.isBestSelling,
    this.isFav,
    this.isNew,
  });
}
