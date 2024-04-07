class ShopProducts {
  int productId;
  String productName;
  int quantity;
  double price;
  double originalPrice;
  String image;

  ShopProducts(
      {required this.productId,
      required this.productName,
      required this.quantity,
      required this.price,
      required this.originalPrice,
      required this.image});

  factory ShopProducts.fromJson(Map<String, dynamic> json) {
    return ShopProducts(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as double,
      originalPrice: json['originalPrice'] as double,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'originalPrice': originalPrice,
      'image': image,
    };
  }
}
