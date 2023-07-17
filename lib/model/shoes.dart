class Shoes {
  final int id;
  final String name;
  final double price;
  final String coverImage;
  final int sold;
  final double rating;
  final List<String>? colors;
  final List<String>? sizes;
  final String? description;
  final int reviews;
  final bool favorite;

  Shoes({
    this.id = 0,
    this.name = "",
    this.price = 0,
    this.coverImage = "",
    this.sold = 0,
    this.rating = 5,
    this.reviews = 0,
    this.colors,
    this.sizes,
    this.description,
    this.favorite = false,
  });

  factory Shoes.fromJson(Map<String, dynamic> json) {
    return Shoes(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      coverImage: json["coverImage"],
      favorite: json["favorite"],
    );
  }

  factory Shoes.fromJsonFavorite(Map<String, dynamic> json) {
    return Shoes(
      id: json["shoesId"],
      name: json["name"],
      price: json["price"],
      coverImage: json["coverImage"],
      favorite: json["favorite"],
    );
  }

  factory Shoes.fromJsonDetail(Map<String, dynamic> json) {
    return Shoes(
      id: json["shoesId"],
      name: json["name"],
      price: json["price"],
      coverImage: json["coverImage"],
      sizes: json["sizes"].cast<String>(),
      colors: json["colors"].cast<String>(),
      description: json["description"],
      favorite: json["favorite"],
    );
  }
}
