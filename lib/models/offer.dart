class Offer {
  int? offerId;
  int? offerMtger;
  String? offerMtgerName;
  String? offerMtgerRate;
  String? offerMtgerPhone;
  String? offerMtgerMapx;
  String? offerMtgerMapy;
  int? offerCartt;
  String? offerState;
  int? offerType;

  int? requestPrice1;
  int? requestPrice1Act;
  String? requestLabel1;
  int? requestPrice2;
  int? requestPrice2Act;
  String? requestLabel2;
  int? requestPrice3;
  int? requestPrice3Act;
  String? requestLabel3;

  int? requestPrice1Offer1;
  int? requestPrice1Offer1Act;
  int? requestPrice1Offer2;
  int? requestPrice1Offer2Act;
  int? requestPrice1Offer3;
  int? requestPrice1Offer3Act;
  String? requestPrice1Label1;
  String? requestPrice1Label2;
  String? requestPrice1Label3;

  int? requestPrice2Offer1;
  int? requestPrice2Offer1Act;
  int? requestPrice2Offer2;
  int? requestPrice2Offer2Act;
  int? requestPrice2Offer3;
  int? requestPrice2Offer3Act;
  String? requestPrice2Label1;
  String? requestPrice2Label2;
  String? requestPrice2Label3;

  int? requestPrice3Offer1;
  int? requestPrice3Offer1Act;
  int? requestPrice3Offer2;
  int? requestPrice3Offer2Act;
  int? requestPrice3Offer3;
  int? requestPrice3Offer3Act;
  String? requestPrice3Label1;
  String? requestPrice3Label2;
  String? requestPrice3Label3;

  String? offerDate;

  Offer({
    this.offerId,
    this.offerMtger,
    this.offerMtgerName,
    this.offerMtgerRate,
    this.offerMtgerPhone,
    this.offerMtgerMapx,
    this.offerMtgerMapy,
    this.offerCartt,
    this.offerState,
    this.offerType,

    this.requestPrice1,
    this.requestPrice1Act,
    this.requestLabel1,
    this.requestPrice2,
    this.requestPrice2Act,
    this.requestLabel2,
    this.requestPrice3,
    this.requestPrice3Act,
    this.requestLabel3,

    this.requestPrice1Offer1,
    this.requestPrice1Offer1Act,
    this.requestPrice1Offer2,
    this.requestPrice1Offer2Act,
    this.requestPrice1Offer3,
    this.requestPrice1Offer3Act,
    this.requestPrice1Label1,
    this.requestPrice1Label2,
    this.requestPrice1Label3,

    this.requestPrice2Offer1,
    this.requestPrice2Offer1Act,
    this.requestPrice2Offer2,
    this.requestPrice2Offer2Act,
    this.requestPrice2Offer3,
    this.requestPrice2Offer3Act,
    this.requestPrice2Label1,
    this.requestPrice2Label2,
    this.requestPrice2Label3,

    this.requestPrice3Offer1,
    this.requestPrice3Offer1Act,
    this.requestPrice3Offer2,
    this.requestPrice3Offer2Act,
    this.requestPrice3Offer3,
    this.requestPrice3Offer3Act,
    this.requestPrice3Label1,
    this.requestPrice3Label2,
    this.requestPrice3Label3,

    this.offerDate,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    offerId: json["offer_id"],
    offerMtger: json["offer_mtger"],

    offerMtgerName: json["offer_mtger_name"],
    offerMtgerRate: json["offer_mtger_rate"],
    offerMtgerPhone: json["offer_mtger_phone"],
    offerMtgerMapx: json["offer_mtger_mapx"],
    offerMtgerMapy: json["offer_mtger_mapy"],
    offerCartt: json["offer_cartt"],
    offerState: json["offer_state"],
    offerType: json["offer_type"],

    requestPrice1: json["requestPrice1"],
    requestPrice1Act: json["requestPrice1Act"],
    requestLabel1: json["requestLabel1"],
    requestPrice2: json["requestPrice2"],
    requestPrice2Act: json["requestPrice2Act"],
    requestLabel2: json["requestLabel2"],
    requestPrice3: json["requestPrice3"],
    requestPrice3Act: json["requestPrice3Act"],
    requestLabel3: json["requestLabel3"],

    requestPrice1Offer1: json["requestPrice1Offer1"],
    requestPrice1Offer1Act: json["requestPrice1Offer1Act"],
    requestPrice1Offer2: json["requestPrice1Offer2"],
    requestPrice1Offer2Act: json["requestPrice1Offer2Act"],
    requestPrice1Offer3: json["requestPrice1Offer3"],
    requestPrice1Offer3Act: json["requestPrice1Offer3Act"],
    requestPrice1Label1: json["requestPrice1Label1"],
    requestPrice1Label2: json["requestPrice1Label2"],
    requestPrice1Label3: json["requestPrice1Label3"],

    requestPrice2Offer1: json["requestPrice2Offer1"],
    requestPrice2Offer1Act: json["requestPrice2Offer1Act"],
    requestPrice2Offer2: json["requestPrice2Offer2"],
    requestPrice2Offer2Act: json["requestPrice2Offer2Act"],
    requestPrice2Offer3: json["requestPrice2Offer3"],
    requestPrice2Offer3Act: json["requestPrice2Offer3Act"],
    requestPrice2Label1: json["requestPrice2Label1"],
    requestPrice2Label2: json["requestPrice2Label2"],
    requestPrice2Label3: json["requestPrice2Label3"],

    requestPrice3Offer1: json["requestPrice3Offer1"],
    requestPrice3Offer1Act: json["requestPrice3Offer1Act"],
    requestPrice3Offer2: json["requestPrice3Offer2"],
    requestPrice3Offer2Act: json["requestPrice3Offer2Act"],
    requestPrice3Offer3: json["requestPrice3Offer3"],
    requestPrice3Offer3Act: json["requestPrice3Offer3Act"],
    requestPrice3Label1: json["requestPrice3Label1"],
    requestPrice3Label2: json["requestPrice3Label2"],
    requestPrice3Label3: json["requestPrice3Label3"],

    offerDate: json["offer_date"],
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "offer_mtger": offerMtger,

    "offer_mtger_name": offerMtgerName,
    "offer_mtger_rate": offerMtgerRate,
    "offer_mtger_phone": offerMtgerPhone,
    "offer_mtger_mapx": offerMtgerMapy,
    "offer_mtger_mapy": offerMtgerMapy,
    "offer_cartt": offerCartt,
    "offer_state": offerState,
    "offer_type": offerType,

    "requestPrice1": requestPrice1,
    "requestPrice1Act": requestPrice1Act,
    "requestLabel1": requestLabel1,
    "requestPrice2": requestPrice2,
    "requestPrice2Act": requestPrice2Act,
    "requestLabel2": requestLabel2,
    "requestPrice3": requestPrice3,
    "requestPrice3Act": requestPrice3Act,
    "requestLabel3": requestLabel3,

    "requestPrice1Offer1": requestPrice1Offer1,
    "requestPrice1Offer1Act": requestPrice1Offer1Act,
    "requestPrice1Offer2": requestPrice1Offer2,
    "requestPrice1Offer2Act": requestPrice1Offer2Act,
    "requestPrice1Offer3": requestPrice1Offer3,
    "requestPrice1Offer3Act": requestPrice1Offer3Act,
    "requestPrice1Label1": requestPrice1Label1,
    "requestPrice1Label2": requestPrice1Label2,
    "requestPrice1Label3": requestPrice1Label3,

    "requestPrice2Offer1": requestPrice2Offer1,
    "requestPrice2Offer1Act": requestPrice2Offer1Act,
    "requestPrice2Offer2": requestPrice2Offer2,
    "requestPrice2Offer2Act": requestPrice2Offer2Act,
    "requestPrice2Offer3": requestPrice2Offer3,
    "requestPrice2Offer3Act": requestPrice2Offer3Act,
    "requestPrice2Label1": requestPrice2Label1,
    "requestPrice2Label2": requestPrice2Label2,
    "requestPrice2Label3": requestPrice2Label3,

    "requestPrice3Offer1": requestPrice3Offer1,
    "requestPrice3Offer1Act": requestPrice3Offer1Act,
    "requestPrice3Offer2": requestPrice3Offer2,
    "requestPrice3Offer2Act": requestPrice3Offer2Act,
    "requestPrice3Offer3": requestPrice3Offer3,
    "requestPrice3Offer3Act": requestPrice3Offer3Act,
    "requestPrice3Label1": requestPrice3Label1,
    "requestPrice3Label2": requestPrice3Label2,
    "requestPrice3Label3": requestPrice3Label3,

    "offer_date": offerDate,
  };
}
