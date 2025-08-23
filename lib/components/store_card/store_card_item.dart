import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/store_state.dart';
import 'package:afaq/models/store.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';

class StoreCardItem extends StatefulWidget {
  final Store? store;

  const StoreCardItem({Key? key, this.store}) : super(key: key);
  @override
  _StoreCardItemState createState() => _StoreCardItemState();
}

class _StoreCardItemState extends State<StoreCardItem> {
  Services _services = Services();

  @override
  Widget build(BuildContext context) {
    final _appState = Provider.of<AppState>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: <Widget>[
            Container(
              color: Color(0xffF9F9F9),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: ClipOval(
                      child: Image.network(
                        widget.store!.mtgerPhoto!,
                        width: constraints.maxWidth * 0.2,
                        height: constraints.maxHeight * 0.8,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 1,
                    height: constraints.maxHeight * 0.7,
                    color: Colors.white,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        height: constraints.maxHeight * 0.23,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset("assets/images/star.png"),
                            Padding(padding: EdgeInsets.all(3)),
                            Text(
                              widget.store!.mtgerRate!,
                              style: TextStyle(color: cText, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        height: constraints.maxHeight * 0.23,
                        child: Text(
                          widget.store!.mtgerName!,
                          style: TextStyle(fontSize: 15, color: cText),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 3),
                        height: constraints.maxHeight * 0.2,
                        child: Text(
                          widget.store!.mtgerAdress!,
                          style: TextStyle(fontSize: 13, color: cHintColor),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset("assets/images/km.png"),
                          Padding(padding: EdgeInsets.all(2)),
                          Text(
                            widget.store!.distance!.toString() + " كم",
                            style: TextStyle(fontSize: 14, color: cText),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              left: constraints.maxWidth * .05,
                            ),
                          ),

                          Image.asset("assets/images/time.png"),
                          Padding(padding: EdgeInsets.all(2)),
                          Text(
                            widget.store!.fromTime!.toString() +
                                "-" +
                                widget.store!.toTime.toString(),
                            style: TextStyle(fontSize: 14, color: cText),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: constraints.maxWidth * .05,
                            ),
                          ),

                          Image.asset("assets/images/tawsil.png"),
                          Padding(padding: EdgeInsets.all(2)),
                          Text(
                            widget.store!.deliveryPrice.toString() + " SR",
                            style: TextStyle(fontSize: 14, color: cText),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: _appState.currentLang == 'ar'
                  ? 0
                  : constraints.maxWidth * 0.97,
              left: _appState.currentLang != 'ar'
                  ? 0
                  : constraints.maxWidth * 0.97,
              top: 0,
              child: _appState.currentUser == null
                  ? IconButton(
                      icon: Icon(Icons.favorite_border, color: cPrimaryColor),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_screen');
                      },
                    )
                  : Consumer<StoreState>(
                      builder: (context, storeState, child) {
                        print(
                          'id ${widget.store!.mtgerId} value ${storeState.isFavouriteList[widget.store!.mtgerId]}',
                        );
                        return IconButton(
                          icon:
                              storeState.isFavouriteList[widget
                                      .store!
                                      .mtgerId] ==
                                  1
                              ? SpinKitPumpingHeart(
                                  color: cPrimaryColor,
                                  size: 24,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: cPrimaryColor,
                                ),
                          onPressed: () async {
                            print(
                              ' before :value ${storeState.isFavouriteList[widget.store!.mtgerId]}',
                            );

                            print(
                              ' after :value ${storeState.isFavouriteList[widget.store!.mtgerId]}',
                            );
                            if (storeState.isFavouriteList[widget
                                    .store!
                                    .mtgerId] ==
                                1) {
                              print('you should delete');
                              await _services.get(
                                'https://mahtco.net/app/api/delete_save_ads?user_id=${_appState.currentUser!.userId}&mtger_id=${widget.store!.mtgerId}',
                              );
                            } else {
                              print('you should add');
                              await _services.get(
                                'https://mahtco.net/app/api/add_fav?user_id=${_appState.currentUser!.userId}&mtger_id=${widget.store!.mtgerId}',
                              );
                            }
                            storeState.updateChangesOnFavouriteList(
                              widget.store!.mtgerId!,
                            );
                          },
                        );
                      },
                    ),
            ),

            Positioned(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.00),
                    topRight: Radius.circular(4.00),
                    bottomLeft: Radius.circular(4.00),
                    bottomRight: Radius.circular(4.00),
                  ),
                  border: Border.all(color: cPrimaryColor),
                ),
                child: Text(widget.store!.state!),
              ),
              left: _appState.currentLang == 'ar'
                  ? 0
                  : constraints.maxWidth * 0.82,
              right: _appState.currentLang != 'ar'
                  ? 0
                  : constraints.maxWidth * 0.82,
              top: 20,
            ),
          ],
        );
      },
    );
  }
}
