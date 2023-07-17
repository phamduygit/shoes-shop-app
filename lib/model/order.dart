class Order {
  int id;
  String imageUrl;
  String name;
  int size;
  int quantity;
  double price;
  String shippingStatus;

  Order({
    this.id = 0,
    this.imageUrl = "",
    this.name = "",
    this.size = 0,
    this.quantity = 0,
    this.price = 0,
    this.shippingStatus = "",
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      name: json["productName"],
      size: json["size"],
      shippingStatus: json["shippingStatus"],
      price: json["price"],
      quantity: json["quantity"],
      imageUrl: json["imageUrl"],
    );
  }
}
