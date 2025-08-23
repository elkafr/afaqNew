import 'package:afaq/screens/driver/orders/components/driver_current_orders.dart';
import 'package:afaq/screens/driver/orders/components/driver_previous_orders.dart';
import 'package:flutter/material.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/tab_state.dart';

import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/not_registered/not_registered.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/screens/orders/components/current_orders.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:afaq/screens/orders/components/previous_orders.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  double _height = 0, _width = 0;

  Widget _buildBodyItem() {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return appState.currentUser != null
            ? ListView(
                children: <Widget>[
                  SizedBox(height: 40),
                  Container(
                    height: _height - _height * .21,
                    child: TabBarView(
                      children: [
                        appState.currentUser!.userType == "user"
                            ? CurrentOrders()
                            : DriverCurrentOrders(),
                        appState.currentUser!.userType == "user"
                            ? PreviousOrders()
                            : DriverPreviousOrders(),
                      ],
                    ),
                  ),
                ],
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
      leading: Text(""),
      title: Text("طلباتي", style: TextStyle(color: cWhite, fontSize: 15)),
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    final tabState = Provider.of<TabState>(context);
    tabState.upadateInitialIndex(0);

    return NetworkIndicator(
      child: PageContainer(
        child: DefaultTabController(
          initialIndex: tabState.initialIndex,
          length: 2,
          child: Scaffold(
            appBar: appBar,
            body: Stack(
              children: <Widget>[
                _buildBodyItem(),
                Positioned(
                  top: 0,
                  child: Container(
                    width: _width,
                    height: 40,
                    color: cWhite,
                    child: TabBar(
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: 'HelveticaNeueW23forSKY',
                      ),
                      unselectedLabelColor: cBlack,
                      unselectedLabelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'HelveticaNeueW23forSKY',
                      ),
                      labelColor: cLightRed,
                      indicatorColor: cLightRed,
                      tabs: [Text("الحالية"), Text("السابقة")],
                    ),
                  ),
                ),
                Center(child: ProgressIndicatorComponent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
