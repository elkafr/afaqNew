import 'package:flutter/material.dart';
import 'package:afaq/models/user.dart';
import 'package:afaq/models/category.dart';
import 'package:afaq/services/access_api.dart';

class AppState extends ChangeNotifier {
  User? _currentUser;
  Services _services = Services();
  void setCurrentUser(User? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }

  User? get currentUser => _currentUser;

  bool? _acceptTerms = false;

  void setAcceptTerms(bool acceptTerms) {
    _acceptTerms = acceptTerms;
    notifyListeners();
  }

  bool? get acceptTerms => _acceptTerms;

  void updateUserEmail(String newUserEmail) {
    _currentUser!.userEmail = newUserEmail;
    notifyListeners();
  }

  void updateUserPhone(String newUserPhone) {
    _currentUser!.userPhone = newUserPhone;
    notifyListeners();
  }

  void updateUserCity(String newUserCity) {
    _currentUser!.userCity = newUserCity;
    notifyListeners();
  }

  void updateUserCityName(String newUserCityName) {
    _currentUser!.userCityName = newUserCityName;
    notifyListeners();
  }

  void updateUserName(String newUserName) {
    _currentUser!.userName = newUserName;
    notifyListeners();
  }

  // current language from shared prefernces 'ar' or 'en'
  String? _currentLang;

  void setCurrentLanguage(String currentLang) {
    _currentLang = currentLang;
    notifyListeners();
  }

  String? get currentLang => _currentLang;
  // int _notificationLength = 0 ;

  // void updateNotification(int value ){
  //   _notificationLength = value;
  //   notifyListeners();
  // }

  // int get notificationLength => _notificationLength;

  String? _phoneSend;

  void setCurrentPhoneSend(String phoneSend) {
    _phoneSend = phoneSend;
    notifyListeners();
  }

  String? get phoneSend => _phoneSend;

  String? _tokenSend;

  void setCurrentTokenSend(String tokenSend) {
    _tokenSend = tokenSend;
    notifyListeners();
  }

  String? get tokenSend => _tokenSend;

  // update current cat
  Category? _selectedCat;
  void setSelectedCat(Category selectedCat) {
    _selectedCat = selectedCat;
    notifyListeners();
  }

  Category get selectedCat => _selectedCat!;

  // update current cat name
  String? _selectedCatName = "العروض";
  void setSelectedCatName(String selectedCatName) {
    _selectedCatName = selectedCatName;
    notifyListeners();
  }

  String get selectedCatName => _selectedCatName ?? "العروض";

  // update current sub
  Category? _selectedSub;
  void setSelectedSub(Category selectedSub) {
    _selectedSub = selectedSub;
    notifyListeners();
  }

  Category? get selectedSub => _selectedSub;

  // filter provider
  int? _filter;
  void setCurrentFilter(int filter) {
    _filter = filter;
    notifyListeners();
  }

  int? get filter => _filter;

  // url provider
  String? _url;
  void setCurrentUrl(String url) {
    _url = url;
    notifyListeners();
  }

  String? get url => _url;

  // add note provider
  String? _note;
  void setCurrentNote(String filter) {
    _note = filter;
    notifyListeners();
  }

  String? get note => _note;

  String? _requestMin;
  void setRequestMin(String requestMin) {
    _requestMin = requestMin;
    notifyListeners();
  }

  String? get requestMin => _requestMin;

  int? _estlam;
  void setEstlam(int estlam) {
    _estlam = estlam;
    notifyListeners();
  }

  int? get estlam => _estlam;

  // add phone111 provider
  String? _phone111;
  void setCurrentPhone111(String phone111) {
    _phone111 = phone111;
    notifyListeners();
  }

  String? get phone111 => _phone111;

  // add tabb provider
  int? _tabb;
  void setCurrentTabb(int tabb) {
    _tabb = tabb;
    notifyListeners();
  }

  int? get tabb => _tabb;

  // select pay method provider
  String? _payMethod;
  void setCurrentPayMethod(String payMethod) {
    _payMethod = payMethod;
    notifyListeners();
  }

  String? get payMethod => _payMethod;

  // cupone value provider
  String? _cupone;
  void setCurrentCupone(String cupone) {
    _cupone = cupone;
    notifyListeners();
  }

  String get cupone => _cupone!;

  // filter orders provider
  int? _filterOrders;
  void setCurrentFilterOrders(int filterOrders) {
    _filterOrders = filterOrders;
    notifyListeners();
  }

  int get filterOrders => _filterOrders!;

  // selectTab provider
  String? _selectTab;
  void setCurrentSelectTab(String selectTab) {
    _selectTab = selectTab;
    notifyListeners();
  }

  String get selectTab => _selectTab!;

  String? _carttNumber;

  void setCurrentCarttNumber(String carttNumber) {
    _carttNumber = carttNumber;
    notifyListeners();
  }

  String? get carttNumber => _carttNumber;

  String? _markaa = '';

  void setMarkaa(String markaa) {
    _markaa = markaa;
    notifyListeners();
  }

  String? get markaa => _markaa;

  String? _currentOfferCartt = '';
  void setCurrentOfferCartt(String currentOfferCartt) {
    _currentOfferCartt = currentOfferCartt;
    notifyListeners();
  }

  String? get currentOfferCartt => _currentOfferCartt;

  String? _currentOfferMtger = '';
  void setCurrentOfferMtger(String currentOfferMtger) {
    _currentOfferMtger = currentOfferMtger;
    notifyListeners();
  }

  String? get currentOfferMtger => _currentOfferMtger;

  String _currentOfferDriver = '';
  void setCurrentOfferDriver(String currentOfferDriver) {
    _currentOfferDriver = currentOfferDriver;
    notifyListeners();
  }

  String get currentOfferDriver => _currentOfferDriver;

  String _currentRequestCartt = '';
  void setCurrentRequestCartt(String currentRequestCartt) {
    _currentRequestCartt = currentRequestCartt;
    notifyListeners();
  }

  String get currentRequestCartt => _currentRequestCartt;

  Future<String> getUnreadNotify() async {
    final response = await _services.get(
      "https://mahtco.net/app/api/get_unread_notify?user_id=${_currentUser!.userId}",
    );
    String messages = '';
    if (response['response'] == '1') {
      messages = response['Number'];
    }
    return messages;
  }

  String? _checkedValue;

  void setCheckedValue(String? checkedValue) {
    _checkedValue = checkedValue;
    notifyListeners();
  }

  String get checkedValue => _checkedValue!;

  String? _checkedValue1;

  void setCheckedValue1(String? checkedValue1) {
    _checkedValue1 = checkedValue1;
    notifyListeners();
  }

  String get checkedValue1 => _checkedValue1!;

  String? _userPhone;

  void setUserPhone(String? userPhone) {
    _userPhone = userPhone;
    notifyListeners();
  }

  String get userPhone => _userPhone!;

  String? _f1;
  void setF1(String? f1) {
    _f1 = f1;
    notifyListeners();
  }

  String get f1 => _f1!;

  String? _f2;
  void setF2(String? f2) {
    _f2 = f2;
    notifyListeners();
  }

  String get f2 => _f2!;

  String? _f2to;
  void setF2To(String? f2) {
    _f2to = f2;
    notifyListeners();
  }

  String get f2to => _f2to!;

  String? _f1to;
  void setF1To(String? f2) {
    _f1to = f2;
    notifyListeners();
  }

  String get f1to => _f1to!;

  String? _f3to;
  void setF3To(String? f2) {
    _f3to = f2;
    notifyListeners();
  }

  String get f3to => _f3to!;
  String? _f3;
  void setF3(String? f3) {
    _f3 = f3;
    notifyListeners();
  }

  String get f3 => _f3!;

  String? _cartText;
  void setCartText(String? f3) {
    _cartText = f3;
    notifyListeners();
  }

  String get cartText => _cartText!;
  String? _searchValue;

  void setSearchValue(String? searchValue) {
    _searchValue = searchValue;
    notifyListeners();
  }

  String get searchValue => _searchValue!;

  int? _currentTawsil;

  void setCurrentTawsil(int currentTawsil) {
    _currentTawsil = currentTawsil;
    // notifyListeners();
  }

  int get currentTawsil => _currentTawsil!;

  double? _currentTotal;

  void setCurrentTotal(double currentTotal) {
    _currentTotal = currentTotal;
    notifyListeners();
  }

  double get currentTotal => _currentTotal!;

  String? _vat;

  void setVat(String? vat) {
    _vat = vat;
    notifyListeners();
  }

  String get vat => _vat!;
}
