class Product {
  final String name;
  final double price;
  final int categoryId;
  final String description;
  final String composision;
  final List<String> images;

  Product({
    required this.name,
    required this.price,
    required this.categoryId,
    required this.description,
    required this.composision,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_name': name,
      'product_price': price,
      'product_category_id': categoryId,
      'product_description': description,
      'product_composision': composision,
      'images': images,
    };
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['category'],
    );
  }
}
