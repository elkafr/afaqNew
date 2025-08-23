class Sacrifice {
  String? adsMtgerId;
  String? adsMtgerName;
  String? adsMtgerPrice;
  dynamic adsMtgerCat;
  String? adsMtgerPhoto;
  String? addCart;
  String? adsMtgerHasOffer;
  String? adsMtgerOffer;

  Sacrifice({
    this.adsMtgerId,
    this.adsMtgerName,
    this.adsMtgerPrice,
    this.adsMtgerCat,
    this.adsMtgerPhoto,
    this.addCart,
    this.adsMtgerHasOffer,
    this.adsMtgerOffer,
  });

  factory Sacrifice.fromJson(Map<String, dynamic> json) => Sacrifice(
    adsMtgerId: json["ads_mtger_id"],
    adsMtgerName: json["ads_mtger_name"],
    adsMtgerPrice: json["ads_mtger_price"],
    adsMtgerCat: json["ads_mtger_cat"],
    adsMtgerPhoto: json["ads_mtger_photo"],
    addCart: json["add_cart"],
    adsMtgerHasOffer: json["ads_mtger_hasoffer"],
    adsMtgerOffer: json["ads_mtger_offer"],
  );

  Map<String, dynamic> toJson() => {
    "ads_mtger_id": adsMtgerId,
    "ads_mtger_name": adsMtgerName,
    "ads_mtger_price": adsMtgerPrice,
    "ads_mtger_cat": adsMtgerCat,
    "ads_mtger_photo": adsMtgerPhoto,
    "add_cart": addCart,
    "ads_mtger_hasoffer": adsMtgerHasOffer,
    "ads_mtger_offer": adsMtgerOffer,
  };
}
