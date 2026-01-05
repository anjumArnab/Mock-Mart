import 'package:get/get.dart';
import 'package:mock_mart/common/models/product_model.dart';
import 'package:mock_mart/utils/images.dart';

class ProductController extends GetxController implements GetxService {
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
}
