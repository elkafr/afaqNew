import 'package:flutter/material.dart';
import 'package:afaq/models/user.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterCodeActivationScreen extends StatefulWidget {
  @override
  _RegisterCodeActivationScreenState createState() =>
      _RegisterCodeActivationScreenState();
}

class _RegisterCodeActivationScreenState
    extends State<RegisterCodeActivationScreen>
    with TickerProviderStateMixin {
  String _activationCode = '';
  double _height = 0, _width = 0;
  Services _services = Services();
  AppState? _appState;
  NavigationState? _navigationState;
  ProgressIndicatorState? _progressIndicatorState;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Widget _buildPinView() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        backgroundColor: Color(0xffF5F6F8),
        length: 4,
        appContext: context,

        animationType: AnimationType.fade,
        animationDuration: Duration(milliseconds: 300),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Theme.of(context).primaryColor,
          selectedColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).primaryColor,
        ),
        onCompleted: (v) {
          print("Completed");
        },
        onChanged: (value) {
          _activationCode = value;
          print(value);
        },
      ),
    );
  }

  Widget _buildBodyItem() {
    return Column(
      children: <Widget>[
        SizedBox(height: _height * 0.2),
        Image.asset('assets/images/codeCheck.png'),
        SizedBox(height: _height * 0.05),

        Container(
          margin: EdgeInsets.only(
            left: _width * 0.1,
            right: _width * 0.1,
            top: _height * 0.05,
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.enterCodeToActivateAccount,
              style: TextStyle(color: cBlack, fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: _height * 0.02),
        Container(
          //  child: Text("00966-"+_appState.phoneSend,style: TextStyle(color: cPrimaryColor,fontSize: 15),),
        ),
        SizedBox(height: _height * 0.02),
        Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.1),
          child: _buildPinView(),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: _width * 0.1,
            vertical: _width * 0.09,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("لم يصلك ؟ ", style: TextStyle(color: cText, fontSize: 15)),
              Padding(padding: EdgeInsets.all(3)),
              GestureDetector(
                child: Text(
                  "أعد إرسال الرمز",
                  style: TextStyle(color: cPrimaryColor, fontSize: 15),
                ),
                onTap: () async {
                  _firebaseMessaging.getToken().then((token) async {
                    //       print('mobile token $token');
                    _progressIndicatorState!.setIsLoading(true);
                    var results = await _services.get(
                      '${Utils.SENDCODE_URL}?user_phone=${_appState!.phoneSend}&token=${_appState!.tokenSend}&lang=${_appState!.currentLang}&key=$cKey',
                    );
                    _progressIndicatorState!.setIsLoading(false);
                    if (results['response'] == '1') {
                      showToast(context, message: results['message']);
                      _appState!.setCurrentUser(
                        User(userId: results['user_id'].toString()),
                      );
                      // Navigator.pushNamed(context, '/register_code_activation_screen' );
                    } else {
                      showErrorDialog(results['message'], context);
                    }
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: _height * 0.1),

        Container(
          height: 60,

          margin: EdgeInsets.symmetric(horizontal: _width * 0.01),
          child: CustomButton(
            btnLbl: AppLocalizations.of(context)!.activation,
            btnColor: cLightLemon,
            onPressedFunction: () async {
              _progressIndicatorState!.setIsLoading(true);
              var results = await _services.get(
                'https://mahtco.net/app/api/active_code?user_id=${_appState!.phone111}&user_code=$_activationCode&lang=${_appState!.currentLang}',
              );
              _progressIndicatorState!.setIsLoading(false);
              if (results['response'] == '1') {
                _appState!.setCurrentUser(
                  User.fromJson(results['user_details']),
                );
                _navigationState!.upadateNavigationIndex(0);
                Navigator.pushReplacementNamed(context, '/navigation');
                showToast(context, message: results['message']);
              } else {
                showErrorDialog(results['message'], context);
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    _navigationState = Provider.of<NavigationState>(context);
    final appBar = AppBar(backgroundColor: Colors.white, elevation: 0.0);
    _height =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),
          body: Stack(
            children: <Widget>[
              ListView(children: <Widget>[_buildBodyItem()]),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: AppLocalizations.of(context)!.activateCode,

                  leading: IconButton(
                    icon: Image.asset(
                      'assets/images/back.png',
                      color: cPrimaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),

              Center(child: ProgressIndicatorComponent()),
            ],
          ),
        ),
      ),
    );
  }
}
