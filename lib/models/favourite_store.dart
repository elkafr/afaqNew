class FavouriteStore {
  String? mtgerId;
  String? mtgerName;
  String? mtgerCat;
  String? mtgerAdress;
  String? mtgerPhoto;

  FavouriteStore({
    this.mtgerId,
    this.mtgerName,
    this.mtgerCat,
    this.mtgerAdress,
    this.mtgerPhoto,
  });

  factory FavouriteStore.fromJson(Map<String, dynamic> json) => FavouriteStore(
    mtgerId: json["mtger_id"],
    mtgerName: json["mtger_name"],
    mtgerCat: json["mtger_cat"],
    mtgerAdress: json["mtger_adress"],
    mtgerPhoto: json["mtger_photo"],
  );

  Map<String, dynamic> toJson() => {
    "mtger_id": mtgerId,
    "mtger_name": mtgerName,
    "mtger_cat": mtgerCat,
    "mtger_adress": mtgerAdress,
    "mtger_photo": mtgerPhoto,
  };
}
