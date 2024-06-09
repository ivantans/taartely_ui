class ProductResponse {
  final String roles;
  final bool success;
  final List<Product> data;

  ProductResponse({
    required this.roles,
    required this.success,
    required this.data,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Product> productList = list.map((i) => Product.fromJson(i)).toList();

    return ProductResponse(
      roles: json['roles'],
      success: json['success'],
      data: productList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roles': roles,
      'success': success,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}


class Category {
  final int id;
  final String category;

  Category({
    required this.id,
    required this.category,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      category: json['category'],
    );
  }
}



class Product {
  final int id;
  final String productName;
  final String productCategory;
  final String productSlug;
  final int productPrice;
  final String productComposition;
  final String productDescription;
  final String productStatus;
  final String? images;
  final double averageRating;
  final int reviewCount;

  Product({
    required this.id,
    required this.productName,
    required this.productCategory,
    required this.productSlug,
    required this.productPrice,
    required this.productComposition,
    required this.productDescription,
    required this.productStatus,
    this.images,
    required this.averageRating, // Added rating
    required this.reviewCount, // Added review count
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['product_name'],
      productCategory: json['product_category'],
      productSlug: json['product_slug'],
      productPrice: json['product_price'],
      productComposition: json['product_composision'],
      productDescription: json['product_description'],
      productStatus: json['product_status'],
      images: json['images'],
      averageRating: json['average_rating'].toDouble(), // Parse the rating
      reviewCount: json['review_count'], // Parse the review count
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_category': productCategory,
      'product_slug': productSlug,
      'product_price': productPrice,
      'product_composision': productComposition,
      'product_description': productDescription,
      'product_status': productStatus,
      'images': images,
      'average_rating': averageRating, // Add rating to JSON
      'review_count': reviewCount, // Add review count to JSON
    };
  }
}
