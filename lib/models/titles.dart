class Titles {
  String? titlesId;
  String? titlesName;
  String? titlesPhoto;

  Titles({this.titlesId, this.titlesName, this.titlesPhoto});

  factory Titles.fromJson(Map<String, dynamic> json) => Titles(
    titlesId: json["titles_id"],
    titlesName: json["titles_name"],
    titlesPhoto: json["titles_photo"],
  );

  Map<String, dynamic> toJson() => {
    "titles_id": titlesId,
    "titles_name": titlesName,
    "titles_photo": titlesPhoto,
  };
}
