import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/models/user.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:afaq/components/MainDrawer.dart';

import 'package:location/location.dart' as gg;
import 'package:location/location.dart';

import 'package:afaq/services/access_api.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool _initialRun = true;
  AppState _appState=AppState();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  NavigationState? _navigationState;
  LocationData? _locData;
  LocationState? _locationState;
  Services _services = Services();

  Future<String>? _termsContent;
  Future<String>? _xxx;

  String? zzz;
  String? zzz1;

  Future<String> _getTermsContent() async {
    var results = await _services.get(
      "https://mahtco.net/app/api/get_unread_notify?user_id=0",
    );
    String termsContent = '';
    if (results['response'] == '1') {
      termsContent = results['Number'];
    } else {
      print('error');
    }
    return termsContent;
  }

  Future<String> getUnreadNotify() async {
    final response = await _services.get(
      "https://mahtco.net/app/api/get_unread_notify?user_id=${_appState.currentUser?.userId}",
    );
    String messages = '';
    if (response['response'] == '1') {
      messages = response['Number'];
      setState(() {
        zzz = response['Number'];
      });
    }
    return messages;
  }

  Future<String> getUnreadCartt() async {
    final response = await _services.get(
      "https://mahtco.net/app/api/get_unread_cartt?user_id=${_appState.currentUser?.userId}",
    );
    String messages = '';
    if (response['response'] == '1') {
      messages = response['Number'];
      setState(() {
        zzz1 = response['Number'];
      });
    }
    return messages;
  }

  Future<Null> _checkIsLogin() async {
    var userData = await SharedPreferencesHelper.read("user");

    if (userData != null) {
      _appState!.setCurrentUser(User.fromJson(userData));
    }
  }

  // Future<Null> _getUnreadNotificationNum() async {
  //   Map<String, dynamic> results =
  //       await _services.get(Utils.NOTIFICATION_UNREAD_URL, header: {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${_appState.currentUser.token}'
  //   });

  //   if (results['status']) {
  //     print(results['data']);

  //     _appState.updateNotification(results['data']['count']);
  //   }
  //     else if (!results['status'] &&
  //                       results['statusCode'] == 401) {
  //                     handleUnauthenticated(context);
  //                   } else {
  //                        showErrorDialog(results['msg'], context);
  //                   }
  // }

  Future<void> _getCurrentUserLocation() async {
    _locData = await gg.Location().getLocation();
    print(_locData!.latitude);
    print(_locData!.longitude);
    _locationState!.setLocationLatitude(_locData!.latitude!);
    _locationState!.setLocationlongitude(_locData!.longitude!);
    List<Placemark> placemark = await placemarkFromCoordinates(
      _locationState!.locationLatitude,
      _locationState!.locationlongitude,
    );
    _locationState!.setCurrentAddress(
      placemark[0].name! +
          '  ' +
          placemark[0].administrativeArea! +
          ' ' +
          placemark[0].country!,
    );
    //  final coordinates = new Coordinates(_locationState.locationLatitude, _locationState
    //  .locationlongitude);
    // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // var first = addresses.first;

    // _locationState.setCurrentAddress(first.addressLine);

    // print("${first.featureName} : ${first.addressLine}");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _locationState = Provider.of<LocationState>(context);
      _termsContent = _getTermsContent();
      getUnreadNotify();
      getUnreadCartt();
      _checkIsLogin();
      //  _getCurrentUserLocation();
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _navigationState = Provider.of<NavigationState>(context);
    _appState = Provider.of<AppState>(context);
    return NetworkIndicator(
      child: Scaffold(
        key: _scaffoldKey, //

        drawer: MainDrawer(),
        body: _navigationState!.selectedContent,

        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: new Icon(Icons.home_filled),
              label: "الرئيسية",
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.wallet),
              label: "طلباتي",
            ),

            BottomNavigationBarItem(
              icon: new Stack(
                children: <Widget>[
                  new Icon(Icons.shopping_cart_sharp),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                      child: new Text(
                        zzz1.toString() == "null" ? "0" : zzz1.toString(),
                        style: new TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              label: "سلتي",
            ),

            BottomNavigationBarItem(
              icon: new Stack(
                children: <Widget>[
                  new Icon(Icons.notifications),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(minWidth: 12, minHeight: 12),
                      child: new Text(
                        zzz.toString() == "null" ? "0" : zzz.toString(),
                        style: new TextStyle(color: Colors.white, fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              label: "الاشعارات",
            ),

            BottomNavigationBarItem(
              icon: new Icon(Icons.account_box),

              label: _appState!.currentLang == "ar" ? "حسابي" : "My account",
            ),
          ],
          currentIndex: _navigationState!.navigationIndex,
          selectedItemColor: cPrimaryColor,
          unselectedItemColor: Color(0xFFC4C4C4),
          onTap: (int index) {
            _navigationState!.upadateNavigationIndex(index);

            print(index);
          },
          elevation: 4,
          backgroundColor: cWhite,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
