import 'package:afaq/components/buttons/custom_button2.dart';
import 'package:flutter/material.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/order_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/order.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

import 'driver_begin_order_bottom_sheet.dart';
import 'driver_end_order_bottom_sheet.dart';

class DriverOrderItem extends StatefulWidget {
  final Order? order;
  final bool? currentOrder;

  const DriverOrderItem({Key? key, this.order, this.currentOrder = true})
    : super(key: key);
  @override
  _DriverOrderItemState createState() => _DriverOrderItemState();
}

class _DriverOrderItemState extends State<DriverOrderItem> {
  Services _services = Services();

  Widget _buildCartItem(String title, int count, int price) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          height: 1.3,
          fontWeight: FontWeight.w400,
          color: cBlack,
          fontSize: 15,
          fontFamily: 'HelveticaNeueW23forSKY',
        ),
        children: <TextSpan>[
          TextSpan(text: title),
          TextSpan(text: ' : '),
          TextSpan(
            text: '( $count )',
            style: TextStyle(
              height: 1.3,
              color: cBlack,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              fontFamily: 'HelveticaNeueW23forSKY',
            ),
          ),
          TextSpan(text: '  '),
          TextSpan(text: price.toString()),
          TextSpan(text: '  '),
          TextSpan(text: AppLocalizations.of(context)!.sr),
        ],
      ),
    );
  }

  Widget _buildItem(String title, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          height: 1.3,
          fontWeight: FontWeight.w400,
          color: cBlack,
          fontSize: 15,
          fontFamily: 'HelveticaNeueW23forSKY',
        ),
        children: <TextSpan>[
          TextSpan(text: title),
          TextSpan(text: ' : '),
          TextSpan(
            text: value,
            style: TextStyle(
              height: 1.3,
              color: cBlack,
              fontWeight: FontWeight.w400,
              fontSize: 15,
              fontFamily: 'HelveticaNeueW23forSKY',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final orderState = Provider.of<OrderState>(context);
    final progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    final appState = Provider.of<AppState>(context);
    return Container(
      width: width,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.all(10),
      height: 210,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '#' + widget.order!.carttFatora!,
              style: TextStyle(
                color: cPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            height: 1,
            width: width,
            color: Colors.grey[300],
          ),
          Padding(padding: EdgeInsets.all(3)),
          _buildItem("اسم العميل", widget.order!.carttUserName!),
          _buildItem("العنوان", widget.order!.carttAdress!),
          _buildItem("تاريخ الطلب", widget.order!.carttDate!),
          _buildItem(
            AppLocalizations.of(context)!.orderPrice,
            widget.order!.carttTotlal.toString() + " ريال ",
          ),
          Padding(padding: EdgeInsets.all(6)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: width * 0.35,
                height: 35,
                child: CustomButton2(
                  btnStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: cWhite,
                  ),

                  btnLbl: AppLocalizations.of(context)!.orderDetails,
                  onPressedFunction: () {
                    orderState.setCarttFatora(widget.order!.carttFatora!);
                    Navigator.pushNamed(
                      context,
                      '/driver_order_details_screen',
                    );
                  },
                ),
              ),
              Spacer(),
              widget.currentOrder!
                  ? Container(
                      padding: (appState.currentLang == 'ar')
                          ? EdgeInsets.only(right: 6)
                          : EdgeInsets.only(left: 6),
                      width: width * 0.35,
                      height: 35,
                      child: CustomButton2(
                        btnStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: cWhite,
                        ),

                        btnLbl: (widget.order!.carttState == '1')
                            ? "بدء التوصيل"
                            : "انهاء التوصيل",
                        btnColor: cPrimaryColor,
                        borderColor: cPrimaryColor,
                        onPressedFunction: () {
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
                                child: (widget.order!.carttState == '1')
                                    ? DriverBeginOrderBottomSheet(
                                        onPressedConfirmation: () async {
                                          progressIndicatorState.setIsLoading(
                                            true,
                                          );
                                          var results = await _services.get(
                                            '${Utils.BEGIN_ORDER_URL}cartt_fatora=${widget.order!.carttFatora}&lang=${appState.currentLang}',
                                          );
                                          progressIndicatorState.setIsLoading(
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
                                        },
                                      )
                                    : DriverEndOrderBottomSheet(
                                        onPressedConfirmation: () async {
                                          progressIndicatorState.setIsLoading(
                                            true,
                                          );
                                          var results = await _services.get(
                                            '${Utils.END_ORDER_URL}cartt_fatora=${widget.order!.carttFatora}&lang=${appState.currentLang}',
                                          );
                                          progressIndicatorState.setIsLoading(
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
                                        },
                                      ),
                              );
                            },
                          );
                          //  showDialog(
                          // barrierDismissible: true,
                          // context: context,
                          // builder: (_) {
                          //   return LogoutDialog(
                          //     alertMessage:
                          //         AppLocalizations.of(context).wantToCancelOrder,
                          //     onPressedConfirm: () async {
                          //      progressIndicatorState.setIsLoading(true);
                          //             var results = await _services.get(
                          //        '${Utils.CANCEL_ORDER_URL}cartt_fatora=${widget.order.carttFatora}&lang=${appState.currentLang}');
                          //             progressIndicatorState.setIsLoading(false);
                          //             if (results['response'] == '1') {
                          //               showToast(results['message'], context);
                          //               Navigator.pop(context);
                          //               Navigator.pushReplacementNamed(
                          //                   context, '/navigation');
                          //             } else {
                          //               showErrorDialog(
                          //                   results['message'], context);
                          //             }
                          //     },
                          //   );
                          // });
                        },
                      ),
                    )
                  : Row(
                      children: <Widget>[
                        SmoothStarRating(
                          allowHalfRating: true,

                          starCount: 5,
                          rating: double.parse(widget.order!.rate.toString()),
                          size: 18.0,
                          color: Color(0xffFFCE42),
                          borderColor: cPrimaryColor,
                          spacing: 0.0,
                        ),
                        Text(
                          '( ${widget.order!.rate} )',
                          style: TextStyle(color: cPrimaryColor, fontSize: 12),
                        ),
                      ],
                    ),
              Padding(padding: EdgeInsets.all(5)),
              GestureDetector(
                child: Icon(Icons.phone_callback, size: 25),
                onTap: () {
                  launch("tel://00966${widget.order!.carttUserPhone}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
