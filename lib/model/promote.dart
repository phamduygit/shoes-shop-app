class Promote {
  final String title;
  final String description;
  final double discountValue;
  final String coverImage;
  final String color;
  final int quantity;
  final DateTime startDate;
  final DateTime endDate;

  const Promote({
    this.title = "",
    this.description = "",
    this.discountValue = 0,
    this.coverImage = "",
    this.color = "#FFFFFF",
    this.quantity = 0,
    required this.startDate,
    required this.endDate,
  });

  factory Promote.fromJson(Map<String, dynamic> json) {
    return Promote(
      title: json["title"],
      color: json["color"],
      discountValue: json["discountValue"],
      description: json["description"],
      quantity: json["quantity"],
      coverImage: json["coverImage"],
      startDate: DateTime.parse(json["startDate"]),
      endDate:  DateTime.parse(json["endDate"]),
    );
  }
}
