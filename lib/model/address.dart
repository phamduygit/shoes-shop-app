class Address {
  final int id;
  final String addressName;
  final String addressDetail;
  final bool selected;

  Address({
    this.id = 0,
    this.addressName = "",
    this.addressDetail = "",
    this.selected = false,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      addressName: json["addressName"],
      addressDetail: json["addressDetail"],
      selected: json["selected"],
    );
  }
}
