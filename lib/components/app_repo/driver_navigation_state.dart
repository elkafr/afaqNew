import 'package:flutter/material.dart';
import 'package:afaq/screens/notifications/notifications_screen.dart';
// import 'package:afaq/screens/driver/account/driver_profile_screen.dart';

import 'package:afaq/screens/driver/orders/driver_orders_screen.dart';

class DriverNavigationState extends ChangeNotifier {
  int _drivernavigationIndex = 0;

  void upadatedriverNavigationIndex(int value) {
    _drivernavigationIndex = value;
    notifyListeners();
  }

  int get drivernavigationIndex => _drivernavigationIndex;

  List<Widget> _screens = [
    DriverOrdersScreen(),
    NotificationsScreen(),

    // DriverProfileScreen()
  ];

  Widget get selectedContent => _screens[_drivernavigationIndex];
}
