class StoreDetails {
  String? mtgerId;
  String? mtgerName;
  String? mtgerAdress;
  String? mtgerPhoto;

  StoreDetails({
    this.mtgerId,
    this.mtgerName,
    this.mtgerAdress,
    this.mtgerPhoto,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
    mtgerId: json["mtger_id"],
    mtgerName: json["mtger_name"],
    mtgerAdress: json["mtger_adress"],
    mtgerPhoto: json["mtger_photo"],
  );

  Map<String, dynamic> toJson() => {
    "mtger_id": mtgerId,
    "mtger_name": mtgerName,
    "mtger_adress": mtgerAdress,
    "mtger_photo": mtgerPhoto,
  };
}
