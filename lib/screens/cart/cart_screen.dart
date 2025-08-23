import 'package:afaq/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:afaq/components/app_repo/payment_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/dialogs/location_dialog.dart';

import 'package:afaq/components/not_registered/not_registered.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/components/title_item/title_item.dart';
import 'package:afaq/models/cart.dart';
import 'package:location/location.dart' as gg;
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/no_data/no_data.dart';
import 'package:validators/validators.dart';

import 'package:geocoding/geocoding.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _height = 0, _width = 0;
  Services _services = Services();
  AppState? _appState;
  bool _isAgree = false;
  bool _initialRun = true;
  String _userPhone = '';
  ProgressIndicatorState? _progressIndicatorState;
  Future<List<Cart>>? _cartList;
  double _totalCost = 0.0;
  LocationState? _locationState;
  LocationData? _locData;
  PaymentState? _paymentState;
  bool checkedValue = false;

  Future<List<Cart>> _getCartList() async {
    Map<dynamic, dynamic> results = await _services.get(
      '${Utils.SHOW_CART_URL}${_appState!.currentUser!.userId}&lang=${_appState!.currentLang}',
    );

    print("carts>>>>>>>>>" + results.toString());
    List<Cart> cartList = <Cart>[];
    if (results['response'] == '1') {
      Iterable iterable = results['ads'];
      cartList = iterable.map((model) => Cart.fromJson(model)).toList();
      if (cartList.length > 0) {
        _totalCost = 0;
        for (int i = 0; i < cartList.length; i++) {
          _totalCost +=
              (double.parse(cartList[i].price!) * cartList[i].cartAmount!);
        }
      }
    } else {
      print('error');
    }
    return cartList;
  }

  bool _checkValidation(
    BuildContext context, {
    String? phone,
    String? address,
  }) {
    if (phone!.trim().length == 0 || !isNumeric(phone)) {
      showToast(context, message: "ادخل رقم الهاتف");
      return false;
    } else if (phone.trim().length < 10 || (phone.trim().length > 10)) {
      showToast(context, message: "رقم الهاتف يجب ان يكون 10 ارقام");
      return false;
    } else if (address == "فضلا ادخل اللوكيشن" || address == null) {
      showToast(context, message: "فضلا ادخل اللوكيشن");
      return false;
    }

    return true;
  }

  Future<void> _getCurrentUserLocation() async {
    _progressIndicatorState!.setIsLoading(true);
    _locData = await gg.Location().getLocation();
    print(_locData!.latitude);
    print(_locData!.longitude);

    if (_locData != null) {
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
      _progressIndicatorState!.setIsLoading(false);
      // _locationState.setCurrentAddress(first.addressLine);

      // print("${first.featureName} : ${first.addressLine}");
    }
  }

  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _locationState = Provider.of<LocationState>(context);
      _cartList = _getCartList();
      _locationState!.initCurrentAddress("فضلا ادخل اللوكيشن");
      _appState!.setCheckedValue("1");
      _initialRun = false;
    }
    super.didChangeDependencies();
  }

  Widget _buildCartItem(Cart cart) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      height: _height * .18,
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: BorderRadius.all(const Radius.circular(15.00)),
        border: Border.all(color: Color(0xff015B2A1A)),
        boxShadow: [
          BoxShadow(
            color: Color(0xff015B2A1A).withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                cart.title!,
                style: TextStyle(
                  color: cBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                height: 1,
                width: _width * 0.6,
                color: Colors.grey[300],
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        //  cart.cartAmount=int.parse(cart.cartAmount!)+1;
                        _totalCost += double.parse(cart.price!);
                      });
                      print('NUMBER: ${cart.cartAmount}');
                      print('NUMBER: ${cart.cartId}');

                      _progressIndicatorState!.setIsLoading(true);
                      var results = await _services.get(
                        "${Utils.UPDATE_AMOUNT_URL}cart_amount=${cart.cartAmount}&cart_id=${cart.cartId}",
                      );
                      _progressIndicatorState!.setIsLoading(false);
                      if (results['response'] == '1') {
                        showToast(context, message: results['message']);
                        _cartList = _getCartList();
                        //  setState(() {
                        //    _totalCost =_totalCost - (cart.price * cart.cartAmount);
                        //   });
                      } else {
                        showErrorDialog(results['message'], context);
                      }
                    },
                    child: Image.asset('assets/images/plus.png'),
                  ),
                  Container(
                    height: 35,
                    width: _width * 0.17,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.00)),
                      border: Border.all(color: cHintColor),
                    ),
                    child: Text(
                      cart.cartAmount.toString(),
                      style: TextStyle(
                        color: cPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (cart.cartAmount! > 1) {
                        setState(() {
                          //  int.parse(cart.cartAmount!--);
                          _totalCost -= double.parse(cart.price!);
                        });

                        print('NUMBER: ${cart.cartAmount}');

                        _progressIndicatorState!.setIsLoading(true);
                        var results = await _services.get(
                          "${Utils.UPDATE_AMOUNT_URL1}cart_amount=${cart.cartAmount}&cart_id=${cart.cartId}",
                        );
                        _progressIndicatorState!.setIsLoading(false);
                        if (results['response'] == '1') {
                          showToast(context, message: results['message']);
                          _cartList = _getCartList();
                          //  setState(() {
                          //    _totalCost =_totalCost - (cart.price * cart.cartAmount);
                          //   });
                        } else {
                          showErrorDialog(results['message'], context);
                        }
                      }
                    },
                    child: Image.asset('assets/images/minus.png'),
                  ),
                ],
              ),
              Spacer(flex: 1),
            ],
          ),
          Spacer(),
          Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: cPrimaryColor,
                radius: 24,
                backgroundImage: NetworkImage(cart.adsMtgerPhoto!),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: cPrimaryColor,
                      fontSize: 16,
                      fontFamily: 'HelveticaNeueW23forSKY',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: (double.parse(cart.price!) * cart.cartAmount!)
                            .toStringAsFixed(2),
                      ),
                      TextSpan(text: '  '),
                      TextSpan(
                        text: "ريال",
                        style: TextStyle(
                          color: cPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'HelveticaNeueW23forSKY',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  _progressIndicatorState!.setIsLoading(true);
                  var results = await _services.get(
                    '${Utils.DELETE_FROM_CART_URL}user_id=${_appState!.currentUser!.userId}&cart_id=${cart.cartId}&lang=${_appState!.currentLang}',
                  );
                  _progressIndicatorState!.setIsLoading(false);
                  if (results['response'] == '1') {
                    showToast(context, message: results['message']);
                    _cartList = _getCartList();
                    //  setState(() {
                    //    _totalCost =_totalCost - (cart.price * cart.cartAmount);
                    //   });
                  } else {
                    showErrorDialog(results['message'], context);
                  }
                },
                child: Container(
                  width: _width * 0.15,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(6.00)),
                    border: Border.all(color: cHintColor),
                  ),
                  child: Center(
                    child: Text(
                      "حذف",
                      style: TextStyle(
                        color: Color(0xffBF0001),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyItem() {
    return FutureBuilder<List<Cart>>(
      future: _cartList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return ListView(
              children: <Widget>[
                Container(
                  height: _height * 0.55,
                  padding: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(snapshot.data![index]);
                    },
                  ),
                ),
                TitleItem(title: "تحديد اللوكيشن"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (_) {
                              return LocationDialog();
                            },
                          );
                        },
                        child: Container(
                          width: _width * 0.25,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: cPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.00),
                            ),
                            border: Border.all(color: cPrimaryColor),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Icon(Icons.map, color: cWhite),
                              ),
                              Text(
                                "تحديد",
                                style: TextStyle(
                                  color: cWhite,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: _width * 0.6,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          _locationState!.address,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffB7B7B7),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                TitleItem(title: "ادخل رقم الهاتف"),
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  margin: EdgeInsets.all(10),
                  child: CustomTextFormField(
                    hintTxt: "رقم الهاتف",
                    inputData: TextInputType.text,
                    onChangedFunc: (String text) {
                      _userPhone = text.toString();
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TitleItem(title: "الوقت المناسب للتوصيل"),
                if (isTimeBefore(int.parse(_appState!.f1to)))
                  Container(
                    margin: EdgeInsets.only(
                      right: _width * .08,
                      left: _width * .08,
                      top: 10,
                    ),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: <Widget>[
                        Text(_appState!.f1),
                        Spacer(),
                        _appState!.checkedValue == "1"
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _progressIndicatorState!.setIsLoading(true);
                                    //_appState!.setCheckedValue(null);
                                    _progressIndicatorState!.setIsLoading(
                                      false,
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: cPrimaryColor,
                                  size: 30,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _progressIndicatorState!.setIsLoading(true);
                                    _appState!.setCheckedValue("1");
                                    print(_appState!.checkedValue);
                                    _progressIndicatorState!.setIsLoading(
                                      false,
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.grey[300],
                                  size: 30,
                                ),
                              ),
                      ],
                    ),
                  ),
                if (isTimeBefore(int.parse(_appState!.f2to)))
                  Container(
                    margin: EdgeInsets.only(
                      right: _width * .08,
                      left: _width * .08,
                      top: 10,
                    ),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: <Widget>[
                        Text(_appState!.f2),
                        Spacer(),
                        _appState!.checkedValue == "2"
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _progressIndicatorState!.setIsLoading(true);
                                    //  _appState!.setCheckedValue(null);
                                    _progressIndicatorState!.setIsLoading(
                                      false,
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: cPrimaryColor,
                                  size: 30,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _progressIndicatorState!.setIsLoading(true);
                                    _appState!.setCheckedValue("2");
                                    print(_appState!.checkedValue);
                                    _progressIndicatorState!.setIsLoading(
                                      false,
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.grey[300],
                                  size: 30,
                                ),
                              ),
                      ],
                    ),
                  ),
                if (isTimeBefore(int.parse(_appState!.f3to)))
                  Container(
                    margin: EdgeInsets.only(
                      right: _width * .08,
                      left: _width * .08,
                      top: 10,
                    ),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: <Widget>[
                        Text(_appState!.f3),
                        Spacer(),
                        _appState!.checkedValue == "3"
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _progressIndicatorState!.setIsLoading(true);
                                    //  _appState!.setCheckedValue(null);
                                    _progressIndicatorState!.setIsLoading(
                                      false,
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: cPrimaryColor,
                                  size: 30,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _progressIndicatorState!.setIsLoading(true);
                                    checkedValue = true;
                                    _appState!.setCheckedValue("3");
                                    print(_appState!.checkedValue);
                                    _progressIndicatorState!.setIsLoading(
                                      false,
                                    );
                                  });
                                },
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.grey[300],
                                  size: 30,
                                ),
                              ),
                      ],
                    ),
                  ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.00)),
                    border: Border.all(color: cHintColor),
                  ),
                  margin: EdgeInsets.only(
                    bottom: 20,
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: _width * 0.26,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                _appState!.currentLang == "ar"
                                    ? "قيمة الطلبات : "
                                    : "value of orders : ",
                                style: TextStyle(
                                  color: cBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cLightRed,
                                  fontSize: 16,
                                  fontFamily: 'HelveticaNeueW23forSKY',
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: _totalCost.toStringAsFixed(2)),
                                  TextSpan(text: '  '),
                                  TextSpan(
                                    text: "ريال",
                                    style: TextStyle(
                                      color: cBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'HelveticaNeueW23forSKY',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: _width * 0.26,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                _appState!.currentLang == "ar"
                                    ? "سعر التوصيل :"
                                    : "Delivery price :",
                                style: TextStyle(
                                  color: cBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cLightRed,
                                  fontSize: 16,
                                  fontFamily: 'HelveticaNeueW23forSKY',
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: _appState!.currentTawsil.toString(),
                                  ),
                                  TextSpan(
                                    text: " ريال ",
                                    style: TextStyle(
                                      color: cBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'HelveticaNeueW23forSKY',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: _width * 0.26,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "الاجمالي : ",
                                style: TextStyle(
                                  color: cBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cLightRed,
                                  fontSize: 16,
                                  fontFamily: 'HelveticaNeueW23forSKY',
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        (_totalCost + _appState!.currentTawsil)
                                            .toStringAsFixed(2),
                                  ),
                                  TextSpan(
                                    text: " ريال ",
                                    style: TextStyle(
                                      color: cBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'HelveticaNeueW23forSKY',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          StatefulBuilder(
                            builder: (context, setState) {
                              return Checkbox(
                                activeColor: cLightRed,
                                value: _isAgree,
                                onChanged: (value) {
                                  setState(() {
                                    _isAgree = value!;
                                  });
                                },
                              );
                            },
                          ),
                          Text(
                            _appState?.cartText ?? "",
                            style: TextStyle(color: cLightRed),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          if (_isAgree) {
                            if (_checkValidation(
                              context,
                              phone: _userPhone,
                              address: _locationState!.address,
                            )) {
                              _appState!.setUserPhone(_userPhone);
                              // Navigator.pushNamed(context,  '/payment_screen');
                              _appState!.setCurrentTotal(_totalCost);

                              if (_totalCost <
                                  int.parse(_appState!.requestMin!)) {
                                showErrorDialog(
                                  "الحد الادنى للطلب هو : " +
                                      _appState!.requestMin! +
                                      " ريال ",
                                  context,
                                );
                              } else {
                                _progressIndicatorState!.setIsLoading(true);
                                var results = await _services.get(
                                  'https://mahtco.net/app/api/checkDistance?latitudeFrom=${_locationState!.locationLatitude}&longitudeFrom=${_locationState!.locationlongitude}',
                                );
                                _progressIndicatorState!.setIsLoading(false);
                                if (results['response'] == '1') {
                                  if (results['distance'] < results['allow']) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentScreen(),
                                      ),
                                    );
                                  } else {
                                    showErrorDialog(
                                      " غير متاح التوصيل لمنطقتك",
                                      context,
                                    );
                                  }
                                } else {
                                  showErrorDialog(results['message'], context);
                                }
                              }
                            }
                          } else {
                            showErrorDialog(_appState!.cartText, context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: cPrimaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: (Radius.circular(15.0)),
                              bottomRight: (Radius.circular(15.0)),
                            ),
                          ),
                          height: 45,
                          width: _width,
                          child: Center(
                            child: Text(
                              "تاكيد الطلب",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: cWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return NoData(message: "لا يوجد منتجات بالسلة");
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: SpinKitSquareCircle(color: cPrimaryColor, size: 25),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      leading: Text(""),
      title: Text("سلة الشراء", style: TextStyle(color: cWhite, fontSize: 16)),
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    // _paymentState = Provider.of<PaymentState>(context);
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          appBar: appBar,
          body: Stack(
            children: <Widget>[
              Consumer<AppState>(
                builder: (context, appState, child) {
                  return appState.currentUser != null
                      ? _buildBodyItem()
                      : NotRegistered();
                },
              ),
              Center(child: ProgressIndicatorComponent()),
            ],
          ),
        ),
      ),
    );
  }
}

bool isTimeBefore(int hour) {
  // final now = DateTime.now();
  //
  // return  now.hour < hour;
  final now = DateTime.now();

  // Adjust the hour by subtracting 4
  final adjustedHour = hour - 3;

  // Check if the current time is before the adjusted hour
  return now.hour < adjustedHour;
}

int convertHourTo12HourFormat(int hour24) {
  if (hour24 < 0 || hour24 > 23) {
    throw FormatException('Invalid hour. The hour should be between 0 and 23.');
  }

  // Convert to 12-hour format
  int hour12 = hour24 % 12;
  if (hour12 == 0) hour12 = 12;

  return hour12;
}
