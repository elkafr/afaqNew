import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/order_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/no_data/no_data.dart';
import 'package:afaq/components/not_registered/not_registered.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/notification_item.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var _height, _width;
  Services _services = Services();
  Future<List<NotificationItem>>? _notificationList;
  AppState? _appState;
  OrderState? _orderState;
  bool _initialRun = true;
  ProgressIndicatorState? _progressIndicatorState;

  Future<List<NotificationItem>> _getNotifications() async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/my_inbox1?page=1&user_id=${_appState!.currentUser!.userId}&lang=${_appState!.currentLang}',
    );
    List notificationsList = <NotificationItem>[];

    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      notificationsList = iterable
          .map((model) => NotificationItem.fromJson(model))
          .toList();
    } else {
      print('error');
    }
    return notificationsList as FutureOr<List<NotificationItem>>;
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
  //   } else if (!results['status'] && results['statusCode'] == 401) {
  //     handleUnauthenticated(context);
  //   } else {
  //     showErrorDialog(results['msg'], context);
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _orderState = Provider.of<OrderState>(context);
      if (_appState!.currentUser != null) {
        _notificationList = _getNotifications();
        // _getUnreadNotificationNum();
      }
      _initialRun = false;
    }
  }

  Widget _buildBodyItem() {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return _appState!.currentUser != null
            ? FutureBuilder<List<NotificationItem>>(
                future: _notificationList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: _width * .82,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: _width * 0.12,
                                          ),
                                          child: Text(
                                            snapshot.data![index].messageTitle!,
                                            style: TextStyle(
                                              color: Color(0xffA7A7A7),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: 8,
                                            bottom: 3,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(
                                                Icons.notifications_active,
                                                color: cPrimaryColor,
                                              ),
                                              SizedBox(width: _width * 0.03),
                                              Flexible(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: snapshot
                                                        .data![index]
                                                        .messageContent,
                                                    style: TextStyle(
                                                      color: cOmarColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: _width * 0.12,
                                          ),
                                          child: Text(
                                            snapshot.data![index].messageDate!,
                                            style: TextStyle(
                                              color: Color(0xffA7A7A7),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: _width * .04,
                                            left: _width * .04,
                                          ),
                                          child: Divider(color: cHintColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  width: _width * .1,
                                  child: GestureDetector(
                                    child: Image.asset(
                                      'assets/images/delete.png',
                                    ),
                                    onTap: () async {
                                      _progressIndicatorState!.setIsLoading(
                                        true,
                                      );

                                      var results = await _services.get(
                                        'https://mahtco.net/app/api/do_delete_message1?id=${snapshot.data![index].messageId}&lang=${_appState!.currentLang}',
                                      );
                                      _progressIndicatorState!.setIsLoading(
                                        false,
                                      );
                                      if (results['response'] == '1') {
                                        showToast(
                                          context,
                                          message: results['message'],
                                        );
                                        setState(() {
                                          _notificationList =
                                              _getNotifications();
                                        });
                                      } else {
                                        showErrorDialog(
                                          results['message'],
                                          context,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return NoData(
                        message: AppLocalizations.of(context)!.noNotifications,
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: SpinKitThreeBounce(color: cPrimaryColor, size: 40),
                  );
                },
              )
            : NotRegistered();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),
          drawer: null,
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    height: _height - (_height * .16),
                    width: _width,
                    padding: EdgeInsets.all(10),
                    child: _buildBodyItem(),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: AppLocalizations.of(context)!.notifications,
                  trailing: _appState!.currentUser != null
                      ? GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.delete_sweep, color: cLightRed),
                                Text(
                                  "حذف الكل",
                                  style: TextStyle(fontSize: 13, color: cWhite),
                                ),
                              ],
                            ),
                          ),
                          onTap: () async {
                            _progressIndicatorState!.setIsLoading(true);

                            var results = await _services.get(
                              'https://mahtco.net/app/api/do_delete_message1_all?user_id=${_appState!.currentUser!.userId}',
                            );
                            _progressIndicatorState!.setIsLoading(false);
                            if (results['response'] == '1') {
                              showToast(context, message: results['message']);
                              setState(() {
                                _notificationList = _getNotifications();
                              });
                            } else {
                              showErrorDialog(results['message'], context);
                            }
                          },
                        )
                      : Text(""),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
