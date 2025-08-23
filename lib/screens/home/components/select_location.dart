import 'dart:async';

import 'package:flutter/material.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/models/location.dart';
import 'package:afaq/utils/app_colors.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/screens/home/home1_screen.dart';
import 'package:afaq/screens/location/addLocation_screen.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/utils.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';

import 'package:afaq/components/response_handling/response_handling.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  Services _services = Services();
  Future<List<Location>>? _locationList;
  AppState? _appState;
  LocationState? _locationState;
  bool _initialRun = true;
  ProgressIndicatorState? _progressIndicatorState;

  Future<List<Location>> _getLocations() async {
    String language = await SharedPreferencesHelper.getUserLang();
    Map<dynamic, dynamic> results = await _services.get(
      Utils.LOCATIONS_URL +
          '?user_id=${_appState!.currentUser != null ? _appState!.currentUser!.userId : "0"}&lang=$language',
    );
    List locationList = <Location>[];
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      locationList = iterable.map((model) => Location.fromJson(model)).toList();
    } else {
      print('error');
    }
    return locationList as FutureOr<List<Location>>;
  }

  @override
  void initState() {
    super.initState();
    _locationList = _getLocations();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
      _locationState = Provider.of<LocationState>(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30,
                child: Image.asset('assets/images/bottomTop.png'),
              ),

              Container(
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "التوصيل لـ",
                      style: TextStyle(
                        color: cText,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      "إختر موقع توصيل الطلب",
                      style: TextStyle(color: cHintColor, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(8)),
              Expanded(
                child: FutureBuilder<List<Location>>(
                  future: _locationList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,

                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home1Screen(),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: GestureDetector(
                                    child: Text(
                                      snapshot.data![index].titlesName!,
                                      style: TextStyle(
                                        color: cText,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      _locationState!.setCurrentAddress(
                                        snapshot.data![index].titlesName!,
                                      );
                                      _locationState!.setLocationLatitude(
                                        double.parse(
                                          snapshot.data![index].locationMapx!,
                                        ),
                                      );
                                      _locationState!.setLocationlongitude(
                                        double.parse(
                                          snapshot.data![index].locationMapy!,
                                        ),
                                      );
                                      Navigator.pop(context);
                                    },
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].locationDetails!,
                                    style: TextStyle(
                                      color: cHintColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                  leading: Image.network(
                                    snapshot.data![index].titlesPhoto!,
                                  ),
                                  trailing: Container(
                                    width: 100,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Image.asset(
                                            'assets/images/edit.png',
                                          ),
                                          onTap: () {},
                                        ),
                                        Padding(padding: EdgeInsets.all(5)),
                                        GestureDetector(
                                          child: Image.asset(
                                            'assets/images/delete.png',
                                          ),
                                          onTap: () async {
                                            _progressIndicatorState!
                                                .setIsLoading(true);

                                            var results = await _services.get(
                                              'https://mahtco.net/app/api/do_delete_location?id=${snapshot.data![index].locationId}&lang=${_appState!.currentLang}',
                                            );
                                            _progressIndicatorState!
                                                .setIsLoading(false);
                                            if (results['response'] == '1') {
                                              showToast(
                                                context,
                                                message: results['message'],
                                              );
                                              Navigator.pop(context);
                                            } else {
                                              showErrorDialog(
                                                results['message'],
                                                context,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(
                      child: SpinKitSquareCircle(
                        color: cPrimaryColor,
                        size: 25,
                      ),
                    );
                  },
                ),
              ),

              Container(
                height: 50,
                child: CustomButton(
                  btnLbl: "إضافة موقع",
                  onPressedFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddLocationScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
