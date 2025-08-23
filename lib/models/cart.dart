class Cart {
  String? title;
  int? cartId;
  int? cartAmount;
  String? price;
  String? adsMtgerPhoto;

  Cart({
    this.title,
    this.cartId,
    this.cartAmount,
    this.price,
    this.adsMtgerPhoto,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    title: json["title"],
    cartId: json["cart_id"],
    cartAmount: json["cart_amount"],
    price: json["price"],
    adsMtgerPhoto: json["ads_mtger_photo"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "cart_id": cartId,
    "cart_amount": cartAmount,

    "price": price,
    "ads_mtger_photo": adsMtgerPhoto,
  };
}
