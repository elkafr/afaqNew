class Type {
  Type({this.typeId, this.typeName});
  String? typeId;
  String? typeName;

  factory Type.fromJson(Map<String, dynamic> json) =>
      Type(typeId: json["type_id"], typeName: json["type_name"]);

  Map<String, dynamic> toJson() => {"type_id": typeId, "type_name": typeName};
}
