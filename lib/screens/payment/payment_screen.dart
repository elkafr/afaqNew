import 'dart:developer';

import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/screens/orders/components/cancel_order_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';

import 'package:provider/provider.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:afaq/components/app_repo/pay_state.dart';

import 'package:afaq/components/not_registered/not_registered.dart';

import 'package:my_fatoorah/my_fatoorah.dart';

Services _services = Services();

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double _height = 0, _width = 0;
  bool _initialRun = true;
  PayState? _payState;
  AppState? _appState;
  NavigationState? _navigationState;
  LocationState? _locationState;
  bool checkedValue1 = false;
  ProgressIndicatorState? _progressIndicatorState;
  Future<String>? _Vat;
  Future<String> _getVat() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String Vat = '';
    if (results['response'] == '1') {
      Vat = results['Vat'];
    } else {
      print('error');
    }
    return Vat;
  }

  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);

      _locationState = Provider.of<LocationState>(context);

      _Vat = _getVat();
      _appState!.setCheckedValue1("2");
      _initialRun = false;
    }
    super.didChangeDependencies();
  }

  Widget _buildBodyItem() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return appState.currentUser != null
            ? Container(
                padding: EdgeInsets.all(_width * .06),
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 5),

                    Text(
                      "شحن وتوصيل المنتج",
                      style: TextStyle(
                        color: cLightRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: _height * .04),

                    Row(
                      children: [
                        Text(
                          "المشتريات",
                          style: TextStyle(color: cText, fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "---------------------",
                          style: TextStyle(color: cLightGrey, fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          _appState!.currentTotal.toStringAsFixed(2),
                          style: TextStyle(
                            color: cLightRed,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(2)),
                        Text(
                          "ريال",
                          style: TextStyle(color: cText, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: _height * .02),
                    Row(
                      children: [
                        Text(
                          "الشحن والتوصيل",
                          style: TextStyle(color: cText, fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "--------------------",
                          style: TextStyle(color: cLightGrey, fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          _appState!.currentTawsil.toString(),
                          style: TextStyle(
                            color: cLightRed,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(2)),
                        Text(
                          "ريال",
                          style: TextStyle(color: cText, fontSize: 14),
                        ),
                      ],
                    ),

                    SizedBox(height: _height * .02),

                    _appState!.checkedValue1 == "1" && _appState!.estlam! > 0
                        ? Row(
                            children: [
                              Text(
                                "رسوم الدفع عند الاستلام",
                                style: TextStyle(color: cText, fontSize: 14),
                              ),
                              Spacer(),
                              Text(
                                "-------------",
                                style: TextStyle(
                                  color: cLightGrey,
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                _appState!.estlam.toString(),
                                style: TextStyle(
                                  color: cLightRed,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(2)),
                              Text(
                                "ريال",
                                style: TextStyle(color: cText, fontSize: 14),
                              ),
                            ],
                          )
                        : Text("", style: TextStyle(height: 0)),
                    _appState!.checkedValue1 == "1" && _appState!.estlam! > 0
                        ? SizedBox(height: _height * .02)
                        : Text("", style: TextStyle(height: 0)),

                    Row(
                      children: [
                        Text(
                          "قيمة الضريبة",
                          style: TextStyle(color: cText, fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "----------------------",
                          style: TextStyle(color: cLightGrey, fontSize: 14),
                        ),
                        Spacer(),

                        FutureBuilder<String>(
                          future: _Vat,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data.toString() + "%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: cLightRed,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            return Center(
                              child: SpinKitThreeBounce(
                                color: cPrimaryColor,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: _height * .04),

                    Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: cLightRed,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(25.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "إجمالى الفاتورة",
                            style: TextStyle(
                              color: cWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Spacer(),
                          Container(width: 2, color: cWhite, height: 40),

                          Spacer(),

                          Column(
                            children: [
                              Row(
                                children: [
                                  _appState!.checkedValue1 == "1" &&
                                          _appState!.estlam! > 0
                                      ? Text(
                                          (_appState!.currentTotal +
                                                  _appState!.currentTawsil +
                                                  _appState!.estlam!)
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            color: cWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        )
                                      : Text(
                                          (_appState!.currentTotal +
                                                  _appState!.currentTawsil)
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            color: cWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                  Text(
                                    " ريال ",
                                    style: TextStyle(
                                      color: cWhite,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),

                              Text(
                                " شامل الضريبة ",
                                style: TextStyle(color: cWhite, fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: _height * .06),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " وسائل الدفع ",
                            style: TextStyle(
                              color: cText,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: _height * .03),

                          DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 4.0,
                            dashColor: Colors.black,
                            dashRadius: 4.0,
                            dashGapLength: 4.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),

                          SizedBox(height: _height * .04),

                          Container(
                            margin: EdgeInsets.only(
                              right: _width * .08,
                              left: _width * .08,
                              top: 10,
                            ),
                            alignment: Alignment.centerRight,

                            child: Row(
                              children: <Widget>[
                                Image.asset("assets/images/cash.png"),
                                Padding(padding: EdgeInsets.all(5)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الدفع عند الإستلام",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Text(
                                      "الدفع النقدي عند إستلام الشحنة",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: cLightGrey,
                                      ),
                                    ),
                                  ],
                                ),

                                Spacer(),
                                _appState!.checkedValue1 == "1"
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _progressIndicatorState!
                                                .setIsLoading(true);
                                            //  _appState!.setCheckedValue1(null);
                                            _progressIndicatorState!
                                                .setIsLoading(false);
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
                                            _progressIndicatorState!
                                                .setIsLoading(true);
                                            _appState!.setCheckedValue1("1");
                                            print(_appState!.checkedValue1);
                                            _progressIndicatorState!
                                                .setIsLoading(false);
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

                          SizedBox(height: _height * .04),
                          Container(
                            margin: EdgeInsets.only(
                              right: _width * .08,
                              left: _width * .08,
                              top: 10,
                            ),
                            alignment: Alignment.centerRight,

                            child: Row(
                              children: <Widget>[
                                Image.asset("assets/images/visa.png"),
                                Padding(padding: EdgeInsets.all(5)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الدفع الإلكتروني",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Text(
                                      "الدفع عن طريق VISA , Master Card",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: cLightGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                _appState!.checkedValue1 == "2"
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _progressIndicatorState!
                                                .setIsLoading(true);
                                            //   _appState!.setCheckedValue1(null);
                                            _progressIndicatorState!
                                                .setIsLoading(false);
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
                                            _progressIndicatorState!
                                                .setIsLoading(true);
                                            _appState!.setCheckedValue1("2");
                                            print(_appState!.checkedValue1);
                                            _progressIndicatorState!
                                                .setIsLoading(false);
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

                          SizedBox(height: _height * .04),

                          Container(
                            child: CustomButton(
                              btnColor: Colors.red,
                              btnLbl: "تأكيد الطلب",
                              onPressedFunction: () async {
                                if (_appState!.checkedValue1 == "1") {
                                  _progressIndicatorState!.setIsLoading(true);
                                  var results = await _services.get(
                                    '${Utils.MAKE_ORDER_URL}user_id=${_appState!.currentUser!.userId}&cartt_phone=${_appState!.userPhone}&cartt_adress=${_locationState!.address}&cartt_mapx=${_locationState!.locationLatitude}&cartt_mapy=${_locationState!.locationlongitude}&cartt_tawsil=${_appState!.checkedValue}&cartt_type=${_appState!.checkedValue1}&cartt_tawsil_value=${_appState!.currentTawsil}&cartt_estlam=${_appState!.estlam != null ? _appState!.estlam! : 0}&lang=${_appState!.currentLang}',
                                  );
                                  _progressIndicatorState!.setIsLoading(false);
                                  if (results['response'] == '1') {
                                    showToast(
                                      context,
                                      message: results['message'],
                                    );

                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/navigation',
                                    );
                                  } else {
                                    showErrorDialog(
                                      results['message'],
                                      context,
                                    );
                                  }
                                } else {
                                  var response = await MyFatoorah.startPayment(
                                    context: context,
                                    request: MyfatoorahRequest.live(
                                      currencyIso: Country.SaudiArabia,
                                      successUrl:
                                          "https://mahtco.net/app/site/success/${_appState!.currentUser!.userId}",
                                      errorUrl:
                                          "https://mahtco.net/app/site/failed/",
                                      invoiceAmount:
                                          _appState!.currentTotal +
                                          _appState!.currentTawsil,
                                      language: ApiLanguage.Arabic,

                                      token:
                                          "FrOQYRRHMqVaPPtl3IB7B8nSOXQHJPw8vpk1IonC4-blUYrnNOS3Whk70j9hYu7_3QqPLp16Dbutm_H5MoDsxG2pJO5lVvdG7R0jfZ9zyPN9ago5KwT76C-FkX9s4zpiqNTaeupptZVys_I1Gr6rn6pC2EPI_LRMJPkVWqemwwtrN9rWoUW7OsmLtDtHEupMR274eOoTnTkzWjZfIjjhECpFEIO8auN_xMwb66ALpx7SLzlxX0ht_7WV84WjuC8mY7v4QfDMI_LpTMzeWWNuApTC7wAqDfLPG1RoDCQcrUVq7QQz28Jb-HNO-0s-1016OXZCShpd9fFnMMu4i55gIF-ayYkL9QKhoimveRUxQbfT2KTcD50FOS0cJy3pM9C4uXJ4yXwRMeNii5XzLLgzBs83gyVhsZ8iz7s1RCshZUOuEiWWLl7v43DZeZhKYUNEe_t0XIURnraM7ZPTzE_0rdrOlj78ILQIMSkzse6MRG5GMOq7qc0LdVtWeaG2z5-Tm4HcSaPLdEAR7VzGZGuF_hKQshlRx2ET-Ezj8HNQQB0Ttkecb2RXeMDvsDXeF8rU2zj3sxabgww3HWDdm4EoBgkcgenyFUA3xSuxyQ2TuvMhzpxIBgqO6k4xjOYzot_IiUp-MA4nCSd6DeyNo3wdp1ZVA8M0Fu05Uu2U8wnaS6CBAbpY_BQbp-KU_ipp37ODXmTtuisn5TlyROJK1_m1w7uZ0Cw",
                                    ),
                                  );
                                  log(response.paymentId.toString());
                                  log(response.status.toString());

                                  if (response.paymentId != null) {
                                    _progressIndicatorState!.setIsLoading(true);
                                    var results = await _services.get(
                                      '${Utils.MAKE_ORDER_URL}user_id=${_appState!.currentUser!.userId}&cartt_phone=${_appState!.userPhone}&cartt_adress=${_locationState!.address}&cartt_mapx=${_locationState!.locationLatitude}&cartt_mapy=${_locationState!.locationlongitude}&cartt_tawsil=${_appState!.checkedValue}&cartt_type=${_appState!.checkedValue1}&cartt_tawsil_value=${_appState!.currentTawsil}&cartt_estlam=0&lang=${_appState!.currentLang}',
                                    );
                                    _progressIndicatorState!.setIsLoading(
                                      false,
                                    );
                                    if (results['response'] == '1') {
                                      showToast(
                                        context,
                                        message: results['message'],
                                      );

                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/navigation',
                                      );
                                    } else {
                                      showErrorDialog(
                                        results['message'],
                                        context,
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : NotRegistered();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      title: Text(
        "معلومات الدفع",
        style: TextStyle(color: cWhite, fontSize: 16),
      ),
      actions: [
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(49.0)),
              color: cLightRed,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),

            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(2)),
                Text("إلغاء", style: TextStyle(color: cWhite, fontSize: 14)),
                Padding(padding: EdgeInsets.all(2)),
                Icon(Icons.cancel, color: cWhite, size: 15),
                Padding(padding: EdgeInsets.all(2)),
              ],
            ),
          ),

          onTap: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              context: context,
              builder: (builder) {
                return Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: CancelOrderBottomSheet(
                    onPressedConfirmation: () async {
                      _progressIndicatorState!.setIsLoading(true);
                      var results = await _services.get(
                        '${Utils.DELETE_ALL_CART_URL}user_id=${_appState!.currentUser!.userId}&lang=${_appState!.currentLang}',
                      );
                      _progressIndicatorState!.setIsLoading(false);
                      if (results['response'] == '1') {
                        showToast(context, message: results['message']);
                        Navigator.pop(context);
                        _navigationState!.upadateNavigationIndex(0);
                        Navigator.pushReplacementNamed(context, '/navigation');
                      } else {
                        showErrorDialog(results['message'], context);
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _navigationState = Provider.of<NavigationState>(context);
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    //_payState= Provider.of<PayState>(context);

    return NetworkIndicator(
      child: PageContainer(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: appBar,
            body: Stack(
              children: <Widget>[
                _buildBodyItem(),

                Center(child: ProgressIndicatorComponent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
