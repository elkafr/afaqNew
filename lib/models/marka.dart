class Marka {
  Marka({this.isSelected, this.markaId, this.markaName});
  bool? isSelected;
  String? markaId;
  String? markaName;

  factory Marka.fromJson(Map<String, dynamic> json) =>
      Marka(markaId: json["marka_id"], markaName: json["marka_name"]);

  Map<String, dynamic> toJson() => {
    "marka_id": markaId,
    "marka_name": markaName,
  };
}
