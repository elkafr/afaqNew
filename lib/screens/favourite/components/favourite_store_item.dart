import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/models/favourite_store.dart';

import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';

class FavouriteStoreItem extends StatefulWidget {
  final FavouriteStore? favouriteStore;

  const FavouriteStoreItem({Key? key, this.favouriteStore}) : super(key: key);
  @override
  _StoreCardItemState createState() => _StoreCardItemState();
}

class _StoreCardItemState extends State<FavouriteStoreItem> {
  Services _services = Services();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    final navigationState = Provider.of<NavigationState>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Image.network(
                    widget.favouriteStore!.mtgerPhoto!,
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxHeight,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 1,
                  height: constraints.maxHeight * 0.7,
                  color: Colors.grey,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      height: constraints.maxHeight * 0.3,
                      child: Text(
                        widget.favouriteStore!.mtgerName!,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: constraints.maxHeight * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Tab(
                              icon: Image.asset(
                                'assets/images/supermarket.png',
                                color: cLightLemon,
                              ),
                            ),
                          ),
                          Text(
                            widget.favouriteStore!.mtgerCat!,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Color(0xffC5C5C5),
                          size: 20,
                        ),
                        Text(
                          widget.favouriteStore!.mtgerAdress!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xffC5C5C5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: appState.currentLang == 'ar'
                  ? 0
                  : constraints.maxWidth * 0.8,
              right: appState.currentLang != 'ar'
                  ? 0
                  : constraints.maxWidth * 0.8,
              top: 0,
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.trashAlt,
                  size: 20,
                  color: cPrimaryColor,
                ),
                onPressed: () async {
                  progressIndicatorState.setIsLoading(true);
                  var results = await _services.get(
                    'https://mahtco.net/app/api/delete_save_ads?mtger_id=${widget.favouriteStore!.mtgerId}&user_id=${appState.currentUser!.userId}&lang=${appState.currentLang}',
                  );
                  progressIndicatorState.setIsLoading(false);
                  if (results['response'] == '1') {
                    showToast(context, message: results['message']);
                    navigationState.upadateNavigationIndex(2);
                    Navigator.pushReplacementNamed(context, '/navigation');
                  } else {
                    showErrorDialog(results['message'], context);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
