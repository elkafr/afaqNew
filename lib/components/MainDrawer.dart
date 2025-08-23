import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/navigation_state.dart';

import 'package:afaq/components/dialogs/log_out_dialog.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/screens/account/about1_screen.dart';
import 'package:afaq/screens/account/about_screen.dart';
import 'package:afaq/screens/account/contact_with_us_screen.dart';
import 'package:afaq/screens/account/terms_screen.dart';
import 'package:afaq/utils/app_colors.dart';
import 'dart:math' as math;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MainDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainDrawer();
  }
}

class _MainDrawer extends State<MainDrawer> {
  double _height = 0, _width = 0;

  AppState? _appState;
  NavigationState? _navigationState;
  bool _initialRun = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _navigationState = Provider.of<NavigationState>(context);

      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.00),
          bottomLeft: Radius.circular(25.00),
        ),

        child: Drawer(
          elevation: 0,

          child: Container(
            color: Color(0xff445969),
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Consumer<AppState>(
                    builder: (context, appState, child) {
                      return _appState!.currentUser == null
                          ? Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),

                                      color: Colors.white,
                                    ),
                                    child: Image.asset(
                                      "assets/images/logo.png",
                                      width: 70,
                                      height: 70,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(7)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(4)),
                                      Text(
                                        "زائر",
                                        style: TextStyle(
                                          color: cWhite,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "الحساب الشخصي",
                                        style: TextStyle(
                                          color: cWhite,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(18),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Consumer<AppState>(
                                    builder: (context, authProvider, child) {
                                      return CircleAvatar(
                                        backgroundColor: cLightLemon,
                                        backgroundImage: NetworkImage(
                                          _appState!.currentUser!.userPhoto !=
                                                  null
                                              ? _appState!
                                                    .currentUser!
                                                    .userPhoto!
                                              : "",
                                        ),
                                        maxRadius: 40,
                                      );
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.all(5)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(4)),
                                      Text(
                                        _appState!.currentUser!.userName!,
                                        style: TextStyle(
                                          color: cWhite,
                                          fontSize: 18,
                                        ),
                                      ),
                                      _appState!.currentUser!.userType == "user"
                                          ? Text(
                                              "الحساب الشخصي",
                                              style: TextStyle(
                                                color: cLightLemon,
                                                fontSize: 16,
                                              ),
                                            )
                                          : Row(
                                              children: <Widget>[
                                                RatingBar.builder(
                                                  initialRating: double.parse(
                                                    _appState!
                                                                .currentUser!
                                                                .userRate !=
                                                            null
                                                        ? _appState!
                                                              .currentUser!
                                                              .userRate!
                                                        : "0",
                                                  ),
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding: EdgeInsets.all(
                                                    0,
                                                  ),
                                                  itemSize: 25,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                  onRatingUpdate: (s) {},
                                                  ignoreGestures: true,
                                                ),
                                              ],
                                            ),
                                      SizedBox(height: 5),

                                      Container(
                                        decoration: BoxDecoration(
                                          color:
                                              _appState!
                                                      .currentUser!
                                                      .userType ==
                                                  "driver"
                                              ? cLightLemon
                                              : cPrimaryColor,
                                          borderRadius: BorderRadius.all(
                                            const Radius.circular(15.00),
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                          right: 11,
                                          left: 11,
                                          top: 6,
                                          bottom: 6,
                                        ),
                                        child: Text(
                                          _appState!.currentUser!.userType ==
                                                  "driver"
                                              ? "مندوب"
                                              : _appState!
                                                        .currentUser!
                                                        .userType ==
                                                    "mtger"
                                              ? "تاجر"
                                              : "مستخدم",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/topDrawer.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                ListTile(
                  leading: Image.asset("assets/images/home.png"),
                  title: Text(
                    AppLocalizations.of(context)!.home,
                    style: TextStyle(color: cWhite, fontSize: 15),
                  ),
                  onTap: () {
                    _navigationState!.upadateNavigationIndex(0);
                    Navigator.pushReplacementNamed(context, '/navigation');
                  },
                ),

                ListTile(
                  leading: Image.asset("assets/images/about.png"),
                  title: Text(
                    AppLocalizations.of(context)!.about,
                    style: TextStyle(color: cWhite, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  },
                ),

                ListTile(
                  leading: Image.asset("assets/images/about.png"),
                  title: Text(
                    "تسجيل الدخول كمندوب",
                    style: TextStyle(color: cWhite, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/driver_login_screen');
                  },
                ),

                ListTile(
                  leading: Image.asset("assets/images/about.png"),
                  title: Text(
                    "كيف نعمل ؟",
                    style: TextStyle(color: cWhite, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => About1Screen()),
                    );
                  },
                ),

                /*  Consumer<AppState>(builder: (context, appState, child) {
                      return  appState.currentUser != null
                          ?  ListTile(
                        onTap: (){
                          Navigator.pushNamed(context, '/personal_information_screen');
                        },
                        leading:Image.asset("assets/images/about.png"),
                        title: Text( AppLocalizations.of(context).personalInfo,style: TextStyle(
                            color: Color(0xff404040),fontSize: 15
                        ), ),
                      ): Container();
                    }), */
                ListTile(
                  leading: Image.asset("assets/images/about.png"),
                  title: Text(
                    AppLocalizations.of(context)!.terms,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset("assets/images/contact.png"),
                  title: Text(
                    AppLocalizations.of(context)!.contactUs,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactWithUsScreen(),
                      ),
                    );
                  },
                ),

                Consumer<AppState>(
                  builder: (context, appState, child) {
                    return appState.currentUser != null
                        ? ListTile(
                            leading: Icon(
                              FontAwesomeIcons.signInAlt,
                              color: cWhite,
                              size: 22,
                            ),
                            title: Text(
                              "حذف الحساب",
                              style: TextStyle(color: cWhite, fontSize: 15),
                            ),
                            onTap: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (_) {
                                  return LogoutDialog(
                                    alertMessage:
                                        "هل متاكد انك تريد حذف الحساب ؟",
                                  );
                                },
                              );
                            },
                          )
                        : Text("");
                  },
                ),

                Consumer<AppState>(
                  builder: (context, appState, child) {
                    return appState.currentUser != null
                        ? ListTile(
                            leading: Icon(
                              FontAwesomeIcons.signInAlt,
                              color: cWhite,
                              size: 22,
                            ),
                            title: Text(
                              AppLocalizations.of(context)!.logOut,
                              style: TextStyle(color: cWhite, fontSize: 15),
                            ),
                            onTap: () {
                              showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (_) {
                                  return LogoutDialog(
                                    alertMessage: AppLocalizations.of(
                                      context,
                                    )!.wantToLogout,
                                  );
                                },
                              );
                            },
                          )
                        : ListTile(
                            leading: Transform.rotate(
                              angle: 180 * math.pi / 180,
                              child: Icon(
                                FontAwesomeIcons.signInAlt,
                                color: cWhite,
                                size: 22,
                              ),
                            ),
                            title: Text(
                              AppLocalizations.of(context)!.enter,
                              style: TextStyle(color: cWhite, fontSize: 15),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/login_screen');
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
