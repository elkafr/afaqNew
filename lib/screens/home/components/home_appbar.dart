import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/store_state.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';

class HomeAppBar extends StatefulWidget {
  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _initialRun = true;
  AppState? _appState;
  Services _services = Services();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreState>(
      builder: (context, storeState, child) {
        return Stack(
          children: <Widget>[
            Container(
              height: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/topbg.png'),
                  fit: BoxFit.cover,
                ),
                color: cPrimaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(500),
                    offset: Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Image.asset('assets/images/toplogo.png')],
              ),
            ),
          ],
        );
      },
    );
  }
}
