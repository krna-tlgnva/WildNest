class Product {
  const Product({
    required this.id,
    required this.title,
    required this.brand,
    required this.description,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.discountPercent,
    required this.badge,
  });

  final int id;
  final String title;
  final String brand;
  final String description;
  final double price;
  final double oldPrice;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int discountPercent;
  final String badge;
}
