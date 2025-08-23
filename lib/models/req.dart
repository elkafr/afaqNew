class Req {
  String? reqId;
  String? reqUser;
  String? reqDate;
  String? reqDone;
  String? reqDoneDate;
  String? reqPhoto;
  String? reqValue;
  String? reqType;

  Req({
    this.reqId,
    this.reqUser,
    this.reqDate,
    this.reqDone,
    this.reqDoneDate,
    this.reqPhoto,
    this.reqValue,
    this.reqType,
  });

  factory Req.fromJson(Map<String, dynamic> json) => Req(
    reqId: json["req_id"],
    reqUser: json["req_user"],
    reqDate: json["req_date"],
    reqDone: json["req_done"],
    reqDoneDate: json["req_done_date"],
    reqPhoto: json["req_photo"],
    reqValue: json["req_value"],
    reqType: json["req_type"],
  );

  Map<String, dynamic> toJson() => {
    "req_id": reqId,
    "req_user": reqUser,
    "req_date": reqDate,
    "req_done": reqDone,
    "req_done_date": reqDoneDate,
    "req_photo": reqPhoto,
    "req_value": reqValue,
    "req_type": reqType,
  };
}
