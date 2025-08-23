class Offer1 {
  int? offerId;
  int? offerDriver;
  String? offerDriverName;
  String? offerDriverRate;
  String? offerDriverPhone;
  String? offerDriverMapx;
  String? offerDriverMapy;
  int? offerCartt;
  int? offerPrice;
  String? offerState;
  String? offerDate;

  Offer1({
    this.offerId,
    this.offerDriver,
    this.offerDriverName,
    this.offerDriverRate,
    this.offerDriverPhone,
    this.offerDriverMapx,
    this.offerDriverMapy,
    this.offerCartt,
    this.offerPrice,
    this.offerState,
    this.offerDate,
  });

  factory Offer1.fromJson(Map<String, dynamic> json) => Offer1(
    offerId: json["offer_id"],
    offerDriver: json["offer_driver"],
    offerDriverName: json["offer_driver_name"],
    offerDriverRate: json["offer_driver_rate"],
    offerDriverPhone: json["offer_driver_phone"],
    offerDriverMapx: json["offer_driver_mapx"],
    offerDriverMapy: json["offer_driver_mapy"],
    offerCartt: json["offer_cartt"],
    offerPrice: json["offer_price"],
    offerState: json["offer_state"],
    offerDate: json["offer_date"],
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "offer_driver": offerDriver,

    "offer_driver_name": offerDriverName,
    "offer_driver_rate": offerDriverRate,
    "offer_driver_phone": offerDriverPhone,
    "offer_driver_mapx": offerDriverMapy,
    "offer_driver_mapy": offerDriverMapy,
    "offer_cartt": offerCartt,
    "offer_state": offerState,
    "offer_price": offerPrice,
    "offer_date": offerDate,
  };
}
