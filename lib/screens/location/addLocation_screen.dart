import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/buttons//custom_button.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/models/titles.dart';

import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/services/access_api.dart';

class AddLocationScreen extends StatefulWidget {
  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markers = Set();
  LocationState? _locationState;
  AppState? _appState;
  Marker? _marker;
  double _height = 0, _width = 0;
  BitmapDescriptor? pinLocationIcon;
  final _formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  Future<List<Titles>>? _titlesList;
  Services _services = Services();
  String _adress = '';
  ProgressIndicatorState? _progressIndicatorState;

  Future<List<Titles>> _getTitlesList() async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/gettitles?lang=${_appState!.currentLang}',
    );
    List bankList = <Titles>[];
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      bankList = iterable.map((model) => Titles.fromJson(model)).toList();
    } else {
      showErrorDialog(results['message'], context);
    }
    return bankList as FutureOr<List<Titles>>;
  }

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/images/pin.png',
    ).then((value) => pinLocationIcon = value);
  }

  @override
  Widget build(BuildContext context) {
    _locationState = Provider.of<LocationState>(context);
    _appState = Provider.of<AppState>(context);
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _titlesList = _getTitlesList();
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    _marker = Marker(
      // optimized: false,
      zIndex: 5,
      onTap: () {
        print('Tapped');
      },
      draggable: true,
      icon: pinLocationIcon!,
      onDragEnd: ((value) async {
        print('ismail');
        print(value.latitude);
        print(value.longitude);
        _locationState!.setLocationLatitude(value.latitude);
        _locationState!.setLocationlongitude(value.longitude);
        //              final coordinates = new Coordinates(
        //                _locationState.locationLatitude, _locationState
        //  .locationlongitude);
        List<Placemark> placemark = await placemarkFromCoordinates(
          _locationState!.locationLatitude,
          _locationState!.locationlongitude,
        );
        _locationState!.setCurrentAddress(placemark[0].name!);

        //   var addresses = await Geocoder.local.findAddressesFromCoordinates(
        //     coordinates);
        //   var first = addresses.first;
        // _locationState.setCurrentAddress(first.addressLine);
        // print(_locationState.address);
      }),
      markerId: MarkerId('my marker'),
      // infoWindow: InfoWindow(title: widget.address),
      position: LatLng(
        _locationState!.locationLatitude,
        _locationState!.locationlongitude,
      ),
      flat: true,
    );
    _markers.add(_marker!);

    return PageContainer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Image.asset("assets/images/back.png", color: cPrimaryColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "إختيار موقع التوصيل",
            style: TextStyle(color: cText, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: _height,
          color: cPrimaryColor,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: _height - (_height * .07),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color: Colors.white,
                ),

                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: _height - (_height * .1),
                              child: GoogleMap(
                                markers: _markers,
                                mapType: MapType.normal,
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                                zoomGesturesEnabled: true,
                                zoomControlsEnabled: true,
                                mapToolbarEnabled: true,

                                // myLocationEnabled: true,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    _locationState!.locationLatitude,
                                    _locationState!.locationlongitude,
                                  ),
                                  zoom: 15,
                                ),
                                onMapCreated:
                                    (GoogleMapController controller) async {
                                      _locationState!.setLocationLatitude(
                                        _locationState!.locationLatitude,
                                      );
                                      _locationState!.setLocationlongitude(
                                        _locationState!.locationlongitude,
                                      );

                                      List<Placemark> placemark =
                                          await placemarkFromCoordinates(
                                            _locationState!.locationLatitude,
                                            _locationState!.locationlongitude,
                                          );
                                      _locationState!.setCurrentAddress(
                                        placemark[0].name! +
                                            '  ' +
                                            placemark[0].administrativeArea! +
                                            ' ' +
                                            placemark[0].country!,
                                      );

                                      controller.setMapStyle(MapStyle.style);
                                      _mapController.complete(controller);

                                      controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            target: LatLng(
                                              _locationState!.locationLatitude,
                                              _locationState!.locationlongitude,
                                            ),
                                            zoom: 15.0,
                                          ),
                                        ),
                                      );
                                    },

                                onCameraMove: ((_position) =>
                                    _updatePosition(_position)),
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: _height * .1,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.00),
                                        topRight: Radius.circular(6.00),
                                        bottomRight: Radius.circular(6.00),
                                        bottomLeft: Radius.circular(6.00),
                                      ),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),

                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(12),

                                    width: _width * .9,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset("assets/images/topmap.png"),
                                        Padding(padding: EdgeInsets.all(2)),
                                        Text(
                                          _locationState!.address != null
                                              ? _locationState!.address
                                              : "",
                                          style: TextStyle(
                                            height: 1.5,
                                            color: cText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: _width * .02),
                                  Container(
                                    height: isSwitched == true
                                        ? _height * .28
                                        : _height * .24,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.00),
                                        topRight: Radius.circular(6.00),
                                        bottomRight: Radius.circular(6.00),
                                        bottomLeft: Radius.circular(6.00),
                                      ),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),

                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(12),

                                    width: _width * .9,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Image.asset(
                                              "assets/images/edit1.png",
                                            ),
                                            Padding(padding: EdgeInsets.all(5)),
                                            Text("وصف الموقع"),
                                          ],
                                        ),
                                        Container(
                                          child: CustomTextFormField(
                                            hintTxt:
                                                "مثال : المنزل , العمل ...",
                                            validationFunc: (value) {
                                              if (value!.trim().length == 0) {
                                                return "فضلا ادخال الوصف";
                                              }
                                              return null;
                                            },
                                            inputData: TextInputType.text,
                                            onChangedFunc: (String text) {
                                              _adress = text.toString();
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.grey[200],
                                          margin: EdgeInsets.only(
                                            top: _width * .03,
                                            bottom: _width * .03,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "حفظ لموقع لاستخدامه لاحقا",
                                              style: TextStyle(
                                                color: cText,
                                                fontSize: 14,
                                              ),
                                            ),

                                            Spacer(),

                                            Switch(
                                              value: isSwitched,
                                              onChanged: (value) {
                                                setState(() {
                                                  isSwitched = value;
                                                  print(isSwitched);
                                                });
                                              },
                                              activeTrackColor: cPrimaryColor,
                                              activeColor: Colors.orangeAccent,
                                            ),
                                          ],
                                        ),

                                        isSwitched == true
                                            ? Container(
                                                height: 45,
                                                width: _width,
                                                child: FutureBuilder<List<Titles>>(
                                                  future: _titlesList,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      if (snapshot
                                                              .data!
                                                              .length >
                                                          0) {
                                                        return ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount: snapshot
                                                              .data!
                                                              .length,
                                                          itemBuilder: (context, index) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                _appState!.setCurrentSelectTab(
                                                                  snapshot
                                                                      .data![index]
                                                                      .titlesId!,
                                                                );
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                padding:
                                                                    EdgeInsets.all(
                                                                      7,
                                                                    ),
                                                                margin:
                                                                    EdgeInsets.only(
                                                                      top: 10,
                                                                      left: 10,
                                                                      right: 10,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                        const Radius.circular(
                                                                          5.00,
                                                                        ),
                                                                      ),
                                                                  border: Border.all(
                                                                    color:
                                                                        _appState!.selectTab ==
                                                                            snapshot.data![index].titlesId
                                                                        ? cPrimaryColor
                                                                        : Colors
                                                                              .grey
                                                                              .shade300,
                                                                  ),
                                                                ),
                                                                width:
                                                                    _width *
                                                                    .24,

                                                                child: Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <Widget>[
                                                                      Image.network(
                                                                        snapshot
                                                                            .data![index]
                                                                            .titlesPhoto!,
                                                                        width:
                                                                            18,
                                                                        height:
                                                                            18,
                                                                        color:
                                                                            _appState!.selectTab ==
                                                                                snapshot.data![index].titlesId
                                                                            ? cPrimaryColor
                                                                            : Colors.grey[400],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                              2,
                                                                            ),
                                                                      ),
                                                                      Text(
                                                                        snapshot
                                                                            .data![index]
                                                                            .titlesName!,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        return Text(
                                                          "لا توجد نتائج",
                                                        );
                                                      }
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                        "${snapshot.error}",
                                                      );
                                                    }
                                                    return Center(
                                                      child:
                                                          SpinKitSquareCircle(
                                                            color:
                                                                cPrimaryColor,
                                                            size: 25,
                                                          ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Text(""),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    height: 50,
                                    width: _width * .99,
                                    child: CustomButton(
                                      btnLbl: "اختيار الموقع الحالي",
                                      onPressedFunction: () async {
                                        if (_formKey.currentState!.validate()) {
                                          print(_adress);
                                          print(_adress);
                                          print(_adress);
                                          print(_adress);
                                          print(_adress);
                                          print(_adress);
                                          print(_adress);
                                          print(_adress);

                                          if (isSwitched == true) {
                                            _progressIndicatorState!
                                                .setIsLoading(true);

                                            var results = await _services.get(
                                              'https://mahtco.net/app/api/addLocation?lang=${_appState!.currentLang}&location_titles=${_appState!.selectTab}&location_details=$_adress&location_mapx=${_locationState!.locationLatitude}&location_mapy=${_locationState!.locationlongitude}&location_user=${_appState!.currentUser!.userId}',
                                            );
                                            _progressIndicatorState!
                                                .setIsLoading(false);
                                            if (results['response'] == '1') {
                                              _locationState!.setCurrentAddress(
                                                _adress,
                                              );
                                              showToast(
                                                context,
                                                message: results['message'],
                                              );
                                              Navigator.pushNamed(
                                                context,
                                                '/navigation',
                                              );
                                            } else {
                                              showErrorDialog(
                                                results['message'],
                                                context,
                                              );
                                            }
                                          } else {
                                            Navigator.pushNamed(
                                              context,
                                              '/navigation',
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _updatePosition(CameraPosition _position) async {
    print(
      'inside updatePosition ${_position.target.latitude} ${_position.target.longitude}',
    );
    // Marker marker = _markers.firstWhere(
    //     (p) => p.markerId == MarkerId('marker_2'),
    //     orElse: () => null);

    _markers.remove(_marker);
    _markers.add(
      Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
        icon: pinLocationIcon!,
      ),
    );
    print(_position.target.latitude);
    print(_position.target.longitude);
    _locationState!.setLocationLatitude(_position.target.latitude);
    _locationState!.setLocationlongitude(_position.target.longitude);
    List<Placemark> placemark = await placemarkFromCoordinates(
      _locationState!.locationLatitude,
      _locationState!.locationlongitude,
    );
    _locationState!.setCurrentAddress(
      placemark[0].name! +
          '  ' +
          placemark[0].administrativeArea! +
          ' ' +
          placemark[0].country!,
    );
    //              final coordinates = new Coordinates(
    //                _locationState.locationLatitude, _locationState
    //  .locationlongitude);
    //       var addresses = await Geocoder.local.findAddressesFromCoordinates(
    //         coordinates);
    //       var first = addresses.first;
    //     _locationState.setCurrentAddress(first.addressLine);
    print(_locationState!.address);
    if (!mounted) return;
    setState(() {});
  }
}

class MapStyle {
  static String style = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
''';
}
