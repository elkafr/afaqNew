class User {
  String? userId;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userCity;
  String? userCityName;
  String? userCredit;
  String? userPhoto;
  String? userType;

  String? userIqama;
  String? carFront;
  String? iqamaPhoto;
  String? carPhoto;
  String? carLicense;
  String? carBack;
  String? userNumberOfCartts;
  String? userMapx;
  String? userMapy;
  String? userMarka;
  String? userRate;

  String? numberOfReq;
  String? totalOfReq;

  User({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userCity,
    this.userCityName,
    this.userCredit,
    this.userPhoto,
    this.userType,

    this.userIqama,
    this.carFront,
    this.iqamaPhoto,
    this.carPhoto,
    this.carLicense,
    this.carBack,
    this.userNumberOfCartts,
    this.userMapx,
    this.userMapy,
    this.userMarka,
    this.userRate,

    this.numberOfReq,
    this.totalOfReq,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    userName: json["user_name"],
    userEmail: json["user_email"],
    userPhone: json["user_phone"],
    userCity: json["user_city"],
    userCityName: json["user_city_name"],
    userCredit: json["user_credit"],
    userPhoto: json["user_photo"],
    userType: json["user_type"],

    userIqama: json["user_iqama"],
    carFront: json["car_front"],
    iqamaPhoto: json["iqama_photo"],
    carPhoto: json["car_photo"],
    carLicense: json["car_license"],
    carBack: json["car_back"],
    userNumberOfCartts: json["user_number_of_cartts"],
    userMapx: json["user_mapx"],
    userMapy: json["user_mapy"],
    userMarka: json["user_marka"],
    userRate: json["user_rate"],

    numberOfReq: json["number_of_req"],
    totalOfReq: json["total_of_req"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "user_email": userEmail,
    "user_phone": userPhone,
    "user_city": userCity,
    "user_city_name": userCityName,
    "user_credit": userCredit,
    "user_photo": userPhoto,
    "user_type": userType,

    "user_iqama": userIqama,
    "car_front": carFront,
    "iqama_photo": iqamaPhoto,
    "car_photo": carPhoto,
    "car_license": carLicense,
    "car_back": carBack,
    "user_number_of_cartts": userNumberOfCartts,
    "user_mapx": userMapx,
    "user_mapy": userMapy,
    "user_marka": userMarka,
    "user_rate": userRate,

    "number_of_req": numberOfReq,
    "total_of_req": totalOfReq,
  };
}
