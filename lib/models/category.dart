class Category {
  String? mtgerCatId;
  String? mtgerCatName;
  String? mtgerCatSub;
  String? mtgerCatColor;
  String? mtgerCatPhoto;
  String? mtgerCatType;
  String? mtgerCatDetails;
  String? mtgerCatShow;
  bool? isSelected = false;

  Category({
    this.mtgerCatId,
    this.mtgerCatName,
    this.mtgerCatSub,
    this.mtgerCatColor,
    this.mtgerCatPhoto,
    this.mtgerCatType,
    this.mtgerCatDetails,
    this.mtgerCatShow,
    this.isSelected,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    mtgerCatId: json["mtger_cat_id"],
    mtgerCatName: json["mtger_cat_name"],
    mtgerCatSub: json["mtger_cat_sub"],
    mtgerCatColor: json["mtger_cat_color"],
    mtgerCatPhoto: json["mtger_cat_photo"],
    mtgerCatType: json["mtger_cat_type"],
    mtgerCatDetails: json["mtger_cat_details"],
    mtgerCatShow: json["mtger_cat_show"],
    isSelected: false,
  );

  Map<String, dynamic> toJson() => {
    "mtger_cat_id": mtgerCatId,
    "mtger_cat_name": mtgerCatName,
    "mtger_cat_sub": mtgerCatSub,
    "mtger_cat_color": mtgerCatColor,
    "mtger_cat_photo": mtgerCatPhoto,
    "mtger_cat_type": mtgerCatType,
    "mtger_cat_details": mtgerCatDetails,
    "mtger_cat_show": mtgerCatShow,
  };
}
