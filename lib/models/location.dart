class Location {
  String? locationId;
  String? locationTitles;
  String? titlesId;
  String? titlesName;
  String? titlesPhoto;
  String? locationDetails;
  String? locationMapx;
  String? locationMapy;
  String? locationUser;

  Location({
    this.locationId,
    this.locationTitles,
    this.titlesId,
    this.titlesName,
    this.titlesPhoto,
    this.locationDetails,
    this.locationMapx,
    this.locationMapy,
    this.locationUser,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationId: json["location_id"],
    locationTitles: json["location_titles"],
    titlesId: json["titles_id"],
    titlesName: json["titles_name"],
    titlesPhoto: json["titles_photo"],
    locationDetails: json["location_details"],
    locationMapx: json["location_mapx"],
    locationMapy: json["location_mapy"],
    locationUser: json["location_user"],
  );

  Map<String, dynamic> toJson() => {
    "location_id": locationId,
    "location_titles": locationTitles,
    "titles_id": titlesId,
    "titles_name": titlesName,
    "titles_photo": titlesPhoto,
    "location_details": locationDetails,
    "location_mapx": locationMapx,
    "location_mapy": locationMapy,
    "location_user": locationUser,
  };
}
