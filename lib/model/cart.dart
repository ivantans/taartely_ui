class Cart {
  final bool success;
  final int id;
  final int totalProduct;
  final int totalQuantity;
  final int totalPrice;
  final List<CartItem> items;

  Cart({
    required this.success,
    required this.id,
    required this.totalProduct,
    required this.totalQuantity,
    required this.totalPrice,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<CartItem> itemsList = list.map((i) => CartItem.fromJson(i)).toList();

    return Cart(
      success: json['success'],
      id: json['id'],
      totalProduct: json['total_product'],
      totalQuantity: json['total_quantity'],
      totalPrice: json['total_price'],
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'id': id,
      'total_product': totalProduct,
      'total_quantity': totalQuantity,
      'total_price': totalPrice,
      'data': items.map((e) => e.toJson()).toList(),
    };
  }
}

class CartItem {
  final int id;
  final int productId;
  final String productName;
  final int productPrice;
  final int quantity;
  final String? productImage;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    this.productImage,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      quantity: json['cart_detail_quantity'],
      productImage: json['product_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_price': productPrice,
      'cart_detail_quantity': quantity,
      'product_image': productImage,
    };
  }
}
