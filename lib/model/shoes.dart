class Shoes {
  final int id;
  final String name;
  final double price;
  final String coverImage;
  final int sold;
  final double rating;

  Shoes({
    required this.id,
    this.name = "",
    this.price = 0,
    this.coverImage = "",
    this.sold = 0,
    this.rating = 5,
  });

  factory Shoes.fromJson(Map<String, dynamic> json) {
    return Shoes(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      coverImage: json["coverImage"],
    );
  }
}
