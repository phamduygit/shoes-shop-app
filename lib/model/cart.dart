class CartItem {
  final int id;
  final String imageUrl;
  final String name;
  final int size;
  final double price;
  int quantity;

  CartItem({
    this.id = 0,
    this.imageUrl = "",
    this.name = "",
    this.size = 0,
    this.price = 0,
    this.quantity = 0,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["itemId"],
      imageUrl: json["shoes"]["coverImage"],
      name: json["shoes"]["name"],
      size: json["size"],
      price: json["shoes"]["price"],
      quantity: json["quantity"],
    );
  }
}
