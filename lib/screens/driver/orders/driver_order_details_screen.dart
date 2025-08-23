import 'package:afaq/components/buttons/custom_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/order_state.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/order.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverOrderDetailsScreen extends StatefulWidget {
  @override
  _DriverOrderDetailsScreenState createState() =>
      _DriverOrderDetailsScreenState();
}

class _DriverOrderDetailsScreenState extends State<DriverOrderDetailsScreen> {
  bool _initialRun = true;
  OrderState? _orderState;
  double _height = 0, _width = 0;
  Services _services = Services();
  AppState? _appState;
  Future<Order>? _orderDetails;

  Future<Order> _getOrderDetails() async {
    Map<dynamic, dynamic> results = await _services.get(
      '${Utils.SHOW_ORDER_DETAILS_URL}lang=${_appState!.currentLang}&user_id=${_appState!.currentUser!.userId}&cartt_fatora=${_orderState!.carttFatora}',
    );
    Order orderDetails = Order();
    if (results['response'] == '1') {
      orderDetails = Order.fromJson(results['result']);
    } else {
      print('error');
    }
    return orderDetails;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _orderState = Provider.of<OrderState>(context);
      _orderDetails = _getOrderDetails();
    }
  }

  Widget _buildRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Text(
            '$title  :  ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: cWhite,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: cWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CarttDetail carttDetail, bool enableDivider) {
    return Container(
      padding: EdgeInsets.only(
        right: _width * .04,
        left: _width * .04,
        top: _width * .01,
        bottom: _width * .01,
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                backgroundColor: cPrimaryColor,
                radius: 28,
                backgroundImage: NetworkImage(carttDetail.carttPhoto!),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carttDetail.carttName!,
                      style: TextStyle(
                        color: cText,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      " (${carttDetail.carttPrice!} ريال )  ",
                      style: TextStyle(
                        color: cDarkGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              Spacer(),

              Container(
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      width: _width * 0.15,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.00)),
                        border: Border.all(color: cHintColor),
                      ),
                      child: Text(
                        "x" + carttDetail.carttAmount.toString(),
                        style: TextStyle(
                          color: cPrimaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: _width * 0.25,
                            alignment: Alignment.center,

                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.00),
                              ),
                              color: cLightRed,
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: cWhite,
                                    fontSize: 15,
                                    fontFamily: 'HelveticaNeueW23forSKY',
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          (carttDetail.carttPrice! *
                                                  carttDetail.carttAmount!)
                                              .toString(),
                                    ),
                                    TextSpan(text: '  '),
                                    TextSpan(
                                      text: "ريال",
                                      style: TextStyle(
                                        color: cWhite,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        fontFamily: 'HelveticaNeueW23forSKY',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Divider(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          enableDivider
              ? Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  width: _width,
                  color: Colors.grey[300],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildBodyItem() {
    return FutureBuilder<Order>(
      future: _orderDetails,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: _width,
            height: _height,
            child: Column(
              children: <Widget>[
                Container(
                  height: _height * 0.6,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.carttDetails!.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(
                        snapshot.data!.carttDetails![index],
                        index != snapshot.data!.carttDetails!.length - 1
                            ? true
                            : false,
                      );
                    },
                  ),
                ),
                Container(
                  height: _height * .2,
                  margin: EdgeInsets.symmetric(
                    horizontal: _width * .04,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: cLightRed,
                    borderRadius: BorderRadius.all(
                      const Radius.circular(15.00),
                    ),
                    border: Border.all(color: cLightRed),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildRow("اسم العميل", snapshot.data!.carttUserName!),
                      SizedBox(height: _height * .02),
                      _buildRow("العنوان", snapshot.data!.carttAdress!),
                      SizedBox(height: _height * .02),
                      _buildRow(
                        AppLocalizations.of(context)!.orderDate,
                        snapshot.data!.carttDate!,
                      ),
                      SizedBox(height: _height * .02),
                      _buildRow(
                        AppLocalizations.of(context)!.orderPrice,
                        '${snapshot.data!.carttTotlal.toString()} ${AppLocalizations.of(context)!.sr}',
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(_width * .04),
                  height: 45,
                  child: CustomButton2(
                    btnStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: cWhite,
                    ),

                    btnLbl: "اللوكيشن",
                    onPressedFunction: () {
                      launch(
                        "http://maps.google.com/maps?q=${snapshot.data!.carttMapx},${snapshot.data!.carttMapy}",
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Center(
          child: SpinKitThreeBounce(color: cPrimaryColor, size: 40),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;

    final appBar = AppBar(
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      leading: GestureDetector(
        child: Consumer<AppState>(
          builder: (context, appState, child) {
            return appState.currentLang == 'ar'
                ? Image.asset('assets/images/back.png', color: cWhite)
                : Image.asset('assets/images/back.png', color: cWhite);
          },
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Consumer<OrderState>(
        builder: (context, orderState, child) {
          return Text(
            '#' + orderState.carttFatora,
            style: TextStyle(color: cWhite, fontSize: 17),
          );
        },
      ),
    );

    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(appBar: appBar, body: _buildBodyItem()),
      ),
    );
  }
}
