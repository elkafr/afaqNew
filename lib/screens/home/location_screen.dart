import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

import 'package:afaq/components/app_repo/location_state.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double _height = 0;
  double _width = 0;
  final _formKey = GlobalKey<FormState>();
  String? _bankTitle, _bankName, _bankAcount, _bankIban;
  Services _services = Services();
  AppState? _appState;
  ProgressIndicatorState? _progressIndicatorState;

  Completer<GoogleMapController> _mapController = Completer();
  Set<Marker> _markers = Set();
  LocationState? _locationState;
  Marker? _marker;

  FocusNode? _focusNode;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode!.dispose();
    super.dispose();
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: cPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.00),
                topRight: Radius.circular(15.00),
              ),
              border: Border.all(color: cHintColor),
            ),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 30,

            child: Text(
              "اختيار اللوكيشن",
              style: TextStyle(
                color: cWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * .95,

            child: GoogleMap(
              markers: _markers,
              mapType: MapType.normal,
              // myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  _locationState!.locationLatitude,
                  _locationState!.locationlongitude,
                ),
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              onCameraMove: ((_position) => _updatePosition(_position)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              _locationState!.address,
              style: TextStyle(
                height: 1.5,
                color: cPrimaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20, right: 15, left: 15),
            child: CustomButton(
              btnColor: cLightLemon,
              btnLbl: "تاكيد",
              onPressedFunction: () async {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),
          body: SingleChildScrollView(
            reverse: true,
            child: Stack(
              children: <Widget>[
                _buildBodyItem(),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GradientAppBar(
                    appBarTitle: "اختيار اللوكيشن",
                    leading: _appState!.currentLang == 'ar'
                        ? IconButton(
                            icon: Image.asset(
                              'assets/images/back.png',
                              color: cPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : Container(),
                    trailing: _appState!.currentLang == 'en'
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: cWhite),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : Container(),
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
