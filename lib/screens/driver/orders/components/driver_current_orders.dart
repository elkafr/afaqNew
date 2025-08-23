import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/no_data/no_data.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/order.dart';
import 'package:afaq/screens/driver/orders/components/driver_order_item.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:provider/provider.dart';

class DriverCurrentOrders extends StatefulWidget {
  @override
  _DriverCurrentOrdersState createState() => _DriverCurrentOrdersState();
}

class _DriverCurrentOrdersState extends State<DriverCurrentOrders> {
  bool _initialRun = true;
  AppState? _appState;
  Services _services = Services();
  Future<List<Order>>? _orderList;

  Future<List<Order>> _getOrderList() async {
    Map<dynamic, dynamic> results = await _services.get(
      '${Utils.DRIVER_ORDERS_URL}lang=${_appState!.currentLang}&user_id=${_appState!.currentUser!.userId}&page=1&done=1',
    );
    List orderList = <Order>[];
    if (results['response'] == '1') {
      Iterable iterable = results['result'];
      orderList = iterable.map((model) => Order.fromJson(model)).toList();
    } else {
      print('error');
    }
    return orderList as FutureOr<List<Order>>;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _orderList = _getOrderList();
      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Order>>(
      future: _orderList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return DriverOrderItem(order: snapshot.data![index]);
              },
            );
          } else {
            return NoData(message: AppLocalizations.of(context)!.noResults);
          }
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        return Center(
          child: SpinKitThreeBounce(color: cPrimaryColor, size: 40),
        );
      },
    );
  }
}
