import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool _acceptTerms = false;

  void setAcceptTerms(bool acceptTerms) {
    _acceptTerms = acceptTerms;
    notifyListeners();
  }

  bool get acceptTerms => _acceptTerms;

  String? _userPhone;

  void setUserPhone(String userPhone) {
    _userPhone = userPhone;
    notifyListeners();
  }

  String get userPhone => _userPhone!;

  String? _codeActivation;

  void setcodeActivation(String code) {
    _codeActivation = code;
    notifyListeners();
  }

  String get codeActivation => _codeActivation!;

  String? _userId;

  void setUserId(String id) {
    _userPhone = id;
    notifyListeners();
  }

  String get userId => _userId!;
}
