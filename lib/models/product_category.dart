class ProductCategory {
  final String id;
  final String name;
  final String imageUrl;
  final String productCount;

  ProductCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.productCount,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['category_id'],
      name: json['category_name'],
      imageUrl: json['category_image'],
      productCount: json['product_count'],
    );
  }
}
