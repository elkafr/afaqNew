class Product {
  String? adsMtgerId;
  String? adsMtgerState;
  String? adsMtgerName;
  String? adsMtgerDetails;
  String? adsMtgerPrice;
  String? adsMtgerColor;
  dynamic adsMtgerCat;
  dynamic adsMtgerSub;
  String? adsMtgerPhoto;
  String? addCart;
  dynamic adsMtgerPriceAfterDiscount;
  dynamic ads_mtger_price_after_discount;

  Product({
    this.adsMtgerId,
    this.adsMtgerState,
    this.adsMtgerName,
    this.adsMtgerDetails,
    this.adsMtgerPrice,
    this.adsMtgerColor,
    this.adsMtgerCat,
    this.adsMtgerSub,
    this.adsMtgerPhoto,
    this.addCart,
    this.adsMtgerPriceAfterDiscount,
    this.ads_mtger_price_after_discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    adsMtgerId: json["ads_mtger_id"],

    ads_mtger_price_after_discount: json["ads_mtger_price_after_discount"],
    adsMtgerPriceAfterDiscount: json["ads_mtger_price_has_discount"],
    adsMtgerState: json["ads_mtger_state"],
    adsMtgerName: json["ads_mtger_name"],
    adsMtgerDetails: json["ads_mtger_details"],
    adsMtgerPrice: json["ads_mtger_price"],
    adsMtgerColor: json["ads_mtger_color"],
    adsMtgerCat: json["ads_mtger_cat"] ?? '',
    adsMtgerSub: json["ads_mtgesub"] ?? '',
    adsMtgerPhoto: json["ads_mtger_photo"],
    addCart: json["add_cart"],
  );

  Map<String, dynamic> toJson() => {
    "ads_mtger_id": adsMtgerId,
    "ads_mtger_state": adsMtgerState,
    "ads_mtger_name": adsMtgerName,
    "ads_mtger_details": adsMtgerDetails,
    "ads_mtger_price": adsMtgerPrice,
    "ads_mtger_color": adsMtgerColor,
    "ads_mtger_cat": adsMtgerCat,
    "ads_mtger_sub": adsMtgerSub,
    "ads_mtger_photo": adsMtgerPhoto,
    "add_cart": addCart,
  };
}
