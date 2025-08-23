import 'package:flutter/material.dart';
import 'package:afaq/screens/notifications/notifications_screen.dart';
import 'package:afaq/screens/account/account_screen.dart';
import 'package:afaq/screens/cart/cart_screen.dart';
import 'package:afaq/screens/home/home_screen.dart';

import 'package:afaq/screens/orders/orders_screen.dart';

class NavigationState extends ChangeNotifier {
  int _navigationIndex = 0;

  void upadateNavigationIndex(int value) {
    _navigationIndex = value;
    notifyListeners();
  }

  int get navigationIndex => _navigationIndex;

  List<Widget> _screens = [
    HomeScreen(),
    OrdersScreen(),
    CartScreen(),
    NotificationsScreen(),

    AccountScreen(),
  ];

  Widget get selectedContent => _screens[_navigationIndex];
}
