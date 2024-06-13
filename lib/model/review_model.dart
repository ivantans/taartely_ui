class Review {
  final int id;
  final int userId;
  final int userOrderDetailId;
  final int productId;
  final String productReviewComment;
  final int isActive;
  final int productReviewRating;
  final DateTime createdAt;
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.userId,
    required this.userOrderDetailId,
    required this.productId,
    required this.productReviewComment,
    required this.isActive,
    required this.productReviewRating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['user_id'],
      userOrderDetailId: json['user_order_detail_id'],
      productId: json['product_id'],
      productReviewComment: json['product_review_comment'],
      isActive: json['is_active'],
      productReviewRating: json['product_review_rating'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
