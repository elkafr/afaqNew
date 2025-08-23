import 'package:flutter/material.dart';
import 'package:afaq/models/store.dart';

class StoreState extends ChangeNotifier {
  // to show details
  Store? _currentStore;

  void setCurrentStore(Store store) {
    _currentStore = store;
    notifyListeners();
  }

  Store get currentStore => _currentStore!;

  Map<String, int> _isFavouriteList = Map<String, int>();

  setIsFavourite(String id, int value) {
    _isFavouriteList[id] = value;
    notifyListeners();
  }

  void updateChangesOnFavouriteList(String id) {
    if (isFavouriteList[id] == 1) {
      isFavouriteList[id] = 0;
    } else {
      isFavouriteList[id] = 1;
    }
    notifyListeners();
  }

  Map<String, int> get isFavouriteList => _isFavouriteList;

  String? _currentStoreId;

  void setCurrentStoreId(String id) {
    _currentStoreId = id;
    notifyListeners();
  }

  String get currentStoreId => _currentStoreId!;

  String? _currentStoreTitle;

  void setCurrentStoreTitle(String title) {
    _currentStoreTitle = title;
    notifyListeners();
  }

  String get currentStoreTitle => _currentStoreTitle!;

  // is_add_to_cart provider
  int? _isAddToCart;
  void setCurrentIsAddToCart(int isAddToCart) {
    _isAddToCart = isAddToCart;
    notifyListeners();
  }

  int get isAddToCart => _isAddToCart!;
}
