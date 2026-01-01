extension DiscountExtension on String {
  /// "20%".applyDiscount("1000") => 800.0
  double applyDiscount(String originalPrice) {
    final double price =
        double.tryParse(originalPrice.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

    final double discountValue =
        double.tryParse(replaceAll('%', '')) ?? 0;

    final double discountAmount = price * (discountValue / 100);

    return price - discountAmount;
  }
}
