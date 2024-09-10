class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String currencyCode;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.currencyCode,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'],
      name: json['product_name'],
      price: json['product_price'],
      imageUrl: json['product_image'],
      currencyCode: json['currency_code'],
      description: json['product_description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': id,
      'product_name': name,
      'product_price': price,
      'product_image': imageUrl,
      'currency_code': currencyCode,
      'product_description': description,
    };
  }
}