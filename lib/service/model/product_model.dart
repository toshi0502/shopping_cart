class Product {
  final String id;
  final String name;
  final String moq;
  final String price;
  final String discountedPrice;

  Product(
      {required this.id,
      required this.name,
      required this.moq,
      required this.price,
      required this.discountedPrice});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      moq: json['moq'],
      price: json['price'],
      discountedPrice: json['discounted_price'],
    );
  }
}
