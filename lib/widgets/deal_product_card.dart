import 'package:flutter/material.dart';
import 'package:mock_mart/constants/text_styles.dart';

class DealProductCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final double price;
  final double rating;
  final int reviews;
  final Color discountColor;

  const DealProductCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.discountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.brown.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Image.asset(
                  'assets/images/img.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite, size: 18, color: Colors.red),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text('$rating ($reviews Reviews)', style: productTitleTextStyle,),
                    const SizedBox(width: 8),
                    Icon(Icons.discount, color: Colors.green),
                  ],
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: productPriceTextStyle,
                ),
                Text('\$$price', style: productPriceTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
