class ProductDetail {
  final int id;
  final String productName;
  final String productStatus;
  final String productCategory;
  final String productSlug;
  final int productPrice;
  final String productComposition;
  final String productDescription;
  final String createdAt;
  final String? images;
  final double averageRating;
  final int reviewCount;

  ProductDetail({
    required this.id,
    required this.productName,
    required this.productStatus,
    required this.productCategory,
    required this.productSlug,
    required this.productPrice,
    required this.productComposition,
    required this.productDescription,
    required this.createdAt,
    this.images,
    required this.averageRating,
    required this.reviewCount,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      productName: json['product_name'],
      productStatus: json['product_status'],
      productCategory: json['product_category'],
      productSlug: json['product_slug'],
      productPrice: json['product_price'],
      productComposition: json['product_composision'],
      productDescription: json['product_description'],
      createdAt: json['created_at'],
      images: json['images'].isNotEmpty ? json['images'][0]['url'] : null,
      averageRating: (json['average_rating'] ?? 0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
    );
  }
}
