class Bank {
  String? bankId;
  String? bankTitle;
  String? bankAcount;
  String? bankIban;
  String? bankName;

  Bank({
    this.bankId,
    this.bankTitle,
    this.bankAcount,
    this.bankIban,
    this.bankName,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    bankId: json["bank_id"],
    bankTitle: json["bank_title"],
    bankAcount: json["bank_acount"],
    bankIban: json["bank_iban"],
    bankName: json["bank_name"],
  );

  Map<String, dynamic> toJson() => {
    "bank_id": bankId,
    "bank_title": bankTitle,
    "bank_acount": bankAcount,
    "bank_iban": bankIban,
    "bank_name": bankName,
  };
}
