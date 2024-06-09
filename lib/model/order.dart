// lib/model/order.dart

class Order {
  final int id;
  final int userId;
  final int userContactId;
  final int orderStatusId;
  final String orderStatusName;
  final String orderNote;
  final String paymentLinkUrl;
  final String orderDueDate;
  final int orderTotalPrice;
  final int orderTotalProduct;
  final int orderTotalQuantity;
  final String orderReason;
  final String createdAt;
  final String updatedAt;
  final List<OrderDetail> orderDetails;

  Order({
    required this.id,
    required this.userId,
    required this.userContactId,
    required this.orderStatusId,
    required this.orderStatusName,
    required this.orderNote,
    required this.paymentLinkUrl,
    required this.orderDueDate,
    required this.orderTotalPrice,
    required this.orderTotalProduct,
    required this.orderTotalQuantity,
    required this.orderReason,
    required this.createdAt,
    required this.updatedAt,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['order_details'] as List;
    List<OrderDetail> detailsList = list.map((i) => OrderDetail.fromJson(i)).toList();

    return Order(
      id: json['id'],
      userId: json['user_id'],
      userContactId: json['user_contact_id'],
      orderStatusId: json['order_status_id'],
      orderStatusName: json['order_status_name'],
      orderNote: json['order_note'],
      paymentLinkUrl: json['payment_link_url'],
      orderDueDate: json['order_due_date'],
      orderTotalPrice: json['order_total_price'],
      orderTotalProduct: json['order_total_product'],
      orderTotalQuantity: json['order_total_quantity'],
      orderReason: json['order_reason'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      orderDetails: detailsList,
    );
  }
}

class OrderDetail {
  final int id;
  final int productId;
  final String productName;
  final int productPrice;
  final int quantity;
  final String? productImage;

  OrderDetail({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    this.productImage,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      productId: json['product_id'],
      productName: json['product_name'],
      productPrice: json['product_price'],
      quantity: json['quantity'],
      productImage: json['product_image'],
    );
  }
}
