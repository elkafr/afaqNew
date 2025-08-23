class CustomerOpinion {
  String? rate1Id;
  String? rate1User;
  String? rate1Value;
  String? rate1Content;

  CustomerOpinion({
    this.rate1Id,
    this.rate1User,
    this.rate1Value,
    this.rate1Content,
  });

  factory CustomerOpinion.fromJson(Map<String, dynamic> json) =>
      CustomerOpinion(
        rate1Id: json["rate1_id"],
        rate1User: json["rate1_user"],
        rate1Value: json["rate1_value"],
        rate1Content: json["rate1_content"],
      );

  Map<String, dynamic> toJson() => {
    "rate1_id": rate1Id,
    "rate1_user": rate1User,
    "rate1_value": rate1Value,
    "rate1_content": rate1Content,
  };
}
