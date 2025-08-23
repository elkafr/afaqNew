class ProductDetails {
  String? adsMtgerId;
  String? adsMtgerState;
  String? adsMtgerName;
  String? adsMtgerCat;
  String? adsMtgerContent;
  String? adsMtgerColor;
  bool? isAddToCart;
  String? adsMtgerPhoto;

  ProductDetails({
    this.adsMtgerId,
    this.adsMtgerState,
    this.adsMtgerName,
    this.adsMtgerCat,
    this.adsMtgerContent,
    this.adsMtgerColor,
    this.isAddToCart,
    this.adsMtgerPhoto,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    adsMtgerId: json["ads_mtger_id"],
    adsMtgerState: json["ads_mtger_state"],
    adsMtgerName: json["ads_mtger_name"],
    adsMtgerCat: json["ads_mtger_cat"],
    adsMtgerContent: json["ads_mtger_content"],
    adsMtgerColor: json["ads_mtger_color"],
    isAddToCart: json["is_add_to_cart"],
    adsMtgerPhoto: json["ads_mtger_photo"],
  );

  Map<String, dynamic> toJson() => {
    "ads_mtger_id": adsMtgerId,
    "ads_mtger_state": adsMtgerState,
    "ads_mtger_name": adsMtgerName,
    "ads_mtger_cat": adsMtgerCat,
    "ads_mtger_content": adsMtgerContent,
    "ads_mtger_color": adsMtgerColor,
    "is_add_to_cart": isAddToCart,
    "ads_mtger_photo": adsMtgerPhoto,
  };
}
