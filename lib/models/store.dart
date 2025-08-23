class Store {
  String? mtgerId;
  String? mtgerName;
  String? mtgerCat;
  String? mtgerSub;
  String? mtgerType;
  String? mtgerRegister;
  String? mtgerAdress;
  String? mtgerMapx;
  String? mtgerMapy;
  String? mtgerRate;
  String? mtgerRateNumber;
  String? userMapx;
  String? userMapy;
  int? distance;
  String? state;
  String? deliveryType;
  String? deliveryFree;
  String? deliveryPrice;
  int? fromTime;
  int? toTime;
  int? isAddToFav;
  String? mtgerPhoto;
  String? mtgerPhoto1;
  int? storeCartValue;

  Store({
    this.mtgerId,
    this.mtgerName,
    this.mtgerCat,
    this.mtgerSub,
    this.mtgerType,
    this.mtgerRegister,
    this.mtgerAdress,
    this.mtgerMapx,
    this.mtgerMapy,
    this.mtgerRate,
    this.mtgerRateNumber,
    this.userMapx,
    this.userMapy,
    this.distance,
    this.state,
    this.deliveryType,
    this.deliveryFree,
    this.deliveryPrice,
    this.fromTime,
    this.toTime,
    this.isAddToFav,
    this.mtgerPhoto,
    this.mtgerPhoto1,
    this.storeCartValue,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    mtgerId: json["mtger_id"],
    mtgerName: json["mtger_name"],
    mtgerCat: json["mtger_cat"],
    mtgerSub: json["mtger_sub"],
    mtgerType: json["mtger_type"],
    mtgerRegister: json["mtger_register"],
    mtgerAdress: json["mtger_adress"],
    mtgerMapx: json["mtger_mapx"],
    mtgerMapy: json["mtger_mapy"],
    mtgerRate: json["mtger_rate"],
    mtgerRateNumber: json["mtger_rate_number"],
    userMapx: json["user_mapx"],
    userMapy: json["user_mapy"],
    distance: json["distance"],
    state: json["state"],
    deliveryType: json["delivery_type"],
    deliveryFree: json["delivery_free"],
    deliveryPrice: json["delivery_price"],
    fromTime: json["from_time"],
    toTime: json["to_time"],
    isAddToFav: json["is_add_to_fav"],
    mtgerPhoto: json["mtger_photo"],
    mtgerPhoto1: json["mtger_photo1"],
    storeCartValue: json["store_cart_value"],
  );

  Map<String, dynamic> toJson() => {
    "mtger_id": mtgerId,
    "mtger_name": mtgerName,
    "mtger_cat": mtgerCat,
    "mtger_sub": mtgerSub,
    "mtger_type": mtgerType,
    "mtger_register": mtgerRegister,
    "mtger_adress": mtgerAdress,
    "mtger_mapx": mtgerMapx,
    "mtger_mapy": mtgerMapy,
    "mtger_rate": mtgerRate,
    "mtger_rate_number": mtgerRateNumber,
    "user_mapx": userMapx,
    "user_mapy": userMapy,
    "distance": distance,
    "state": state,
    "delivery_type": deliveryType,
    "delivery_free": deliveryFree,
    "delivery_price": deliveryPrice,
    "from_time": fromTime,
    "to_time": toTime,
    "is_add_to_fav": isAddToFav,
    "mtger_photo": mtgerPhoto,
    "mtger_photo1": mtgerPhoto1,
    "store_cart_value": storeCartValue,
  };
}
