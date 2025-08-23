import 'package:flutter/material.dart';

class PaymentState extends ChangeNotifier {
  bool _enableCardsAndBankAccounts = true;

  void setEnableCardsAndBankAccounts(bool value) {
    _enableCardsAndBankAccounts = value;
    notifyListeners();
  }

  bool get enableCardsAndBankAccounts => _enableCardsAndBankAccounts;

  String? _userPhone;

  void setUserPhone(String phone) {
    _userPhone = phone;
    notifyListeners();
  }

  String get userPhone => _userPhone!;
}
