import 'package:afaq/screens/auth/login_screen.dart';
import 'package:afaq/screens/auth/password_recovery_screen.dart';
import 'package:afaq/screens/auth/register_code_activation1_screen.dart';
import 'package:afaq/screens/auth/register_code_activation_screen.dart';
import 'package:afaq/screens/auth/register_screen.dart';
import 'package:afaq/screens/bottom_navigation.dart/bottom_navigation_bar.dart';
import 'package:afaq/screens/cart/cart_screen.dart';

import 'package:afaq/screens/driver/orders/driver_order_details_screen.dart';

import 'package:afaq/screens/location/addLocation_screen.dart';
import 'package:afaq/screens/notifications/notifications_screen.dart';

import 'package:afaq/screens/orders/order_details_screen.dart';

import 'package:afaq/screens/orders/orders_screen.dart';

import 'package:afaq/screens/profile/personal_information_screen.dart';
import 'package:afaq/screens/splash/splash_screen.dart';

final routes = {
  '/': (context) => SplashScreen(),
  '/login_screen': (context) => LoginScreen(),
  '/password_recovery_screen': (context) => PasswordRecoveryScreen(),
  '/register_screen': (context) => RegisterScreen(),

  '/navigation': (context) => BottomNavigation(),
  '/order_details_screen': (context) => OrderDetailsScreen(),
  '/driver_order_details_screen': (context) => DriverOrderDetailsScreen(),

  '/orders_screen': (context) => OrdersScreen(),
  '/cart_screen': (context) => CartScreen(),
  '/personal_information_screen': (context) => PersonalInformationScreen(),
  '/notifications_screen': (context) => NotificationsScreen(),

  '/register_code_activation_screen': (context) =>
      RegisterCodeActivationScreen(),
  '/register_code_activation1_screen': (context) =>
      RegisterCodeActivation1Screen(),
  '/addLocation_screen': (context) => AddLocationScreen(),
};
