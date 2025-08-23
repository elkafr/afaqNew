import 'package:flutter/material.dart';

class LocationState extends ChangeNotifier {
  String? _address;

  void setCurrentAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void initCurrentAddress(String address) {
    _address = address;
  }

  String get address => _address!;

  double? _locationLatitude;

  void setLocationLatitude(double lat) {
    _locationLatitude = lat;
    notifyListeners();
  }

  double get locationLatitude => _locationLatitude??24.7136;

  double? _locationlongitude;

  void setLocationlongitude(double long) {
    _locationlongitude = long;
    notifyListeners();
  }

  double get locationlongitude => _locationlongitude??46.6753;

  String? _anotherAdress;

  void setAnotherAdress(String anotherAdress) {
    _anotherAdress = anotherAdress;
    notifyListeners();
  }

  String get anotherAdress => _anotherAdress!;
}
