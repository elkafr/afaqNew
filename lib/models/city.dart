class City {
  String? cityId;
  String? cityName;

  City({this.cityId, this.cityName});

  factory City.fromJson(Map<String, dynamic> json) =>
      City(cityId: json["city_id"], cityName: json["city_name"]);

  Map<String, dynamic> toJson() => {"city_id": cityId, "city_name": cityName};
}
