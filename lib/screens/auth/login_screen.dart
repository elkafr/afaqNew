import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/user.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/utils.dart';
import 'package:afaq/screens/auth/password_recovery_bottom_sheet.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _height = 0;
  double _width = 0;
  final _formKey = GlobalKey<FormState>();
  String? _userPhone, _userPassword;
  Services _services = Services();
  ProgressIndicatorState? _progressIndicatorState;
  AppState? _appState;
  NavigationState? _navigationState;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Get Firebase token for both Android and iOS platforms
  Future<String?> _getFirebaseToken() async {
    try {
      String? token;
      
      if (Platform.isIOS) {
        // iOS: Get APNS token
        token = await _firebaseMessaging.getAPNSToken();
        print('iOS APNS token: $token');
      } else {
        // Android: Get FCM token
        token = await _firebaseMessaging.getToken();
        print('Android FCM token: $token');
      }
      
      return token;
    } catch (e) {
      print('Error getting Firebase token: $e');
      return null;
    }
  }

  /// Setup Firebase messaging for the current platform
  Future<void> _setupFirebaseMessaging() async {
    try {
      // Request notification permissions
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      
      print('User granted permission: ${settings.authorizationStatus}');
      
      // Get initial token
      String? initialToken = await _getFirebaseToken();
      print('Initial Firebase token: $initialToken');
      
      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        print('Firebase token refreshed: $newToken');
        // You can send this new token to your server here
      });
      
    } catch (e) {
      print('Error setting up Firebase messaging: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: _height * 0.09),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.08),
                alignment: Alignment.center,
                child: Text(
                  "أهلا ومرحبا  ",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    color: cWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: _width * .08),
            Container(
              margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
              child: Center(child: Image.asset('assets/images/box.png')),
            ),
            SizedBox(height: _width * .06),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.09),
                alignment: Alignment.center,
                child: Text(
                  "تسجيل دخول ",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 17,
                    color: cWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: _width * .4),

            Container(
              child: CustomTextFormField(
                iconIsImage: true,
                imagePath: 'assets/images/user.png',
                hintTxt: AppLocalizations.of(context)!.phoneNo,
                suffixIcon: Image.asset("assets/images/sa.png"),
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return AppLocalizations.of(context)!.phonoNoValidation;
                  }

                  if (value.trim().length != 9) {
                    return "يجب ان يكون  رقم الهاتف مكون من 9 ارقايم ويبدء ب 5 ";
                  }
                  return null;
                },
                inputData: TextInputType.number,
                onChangedFunc: (String text) {
                  _userPhone = text.toString();
                },
              ),
            ),

            SizedBox(height: _width * .02),

            Container(
              child: CustomTextFormField(
                isPassword: true,
                iconIsImage: true,
                imagePath: 'assets/images/password.png',
                hintTxt: AppLocalizations.of(context)!.password,
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return AppLocalizations.of(context)!.password;
                  }
                  return null;
                },

                onChangedFunc: (String text) {
                  _userPassword = text.toString();
                },
              ),
            ),
            SizedBox(height: _width * .01),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: _width * 0.07,
                vertical: _height * 0.02,
              ),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    context: context,
                    builder: (builder) {
                      return SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: PasswordRecoveryBottomSheet(),
                        ),
                      );
                    },
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    children: <TextSpan>[TextSpan(text: "نسيت كلمة المرور ؟")],
                  ),
                ),
              ),
            ),

            SizedBox(height: _width * .2),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                child: CustomButton(
                  btnColor: cLightLemon,
                  btnLbl: 'تسجيل دخول',
                  onPressedFunction: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Get Firebase token for both platforms
                        String? token = await _getFirebaseToken();
                        
                        _progressIndicatorState!.setIsLoading(true);
                        var results = await _services.get(
                          '${Utils.LOGIN_URL}?user_phone=$_userPhone&user_pass=$_userPassword&token=$token&lang=${_appState!.currentLang}&key=$cKey',
                        );
                        _progressIndicatorState!.setIsLoading(false);
                        
                        if (results['response'] == '1') {
                          _appState!.setCurrentPhoneSend(_userPhone!);
                          _appState!.setCurrentTokenSend(token ?? "");
                          showToast(context, message: results['message']);
                          _appState!.setCurrentUser(
                            User.fromJson(results["user_details"]),
                          );
                          SharedPreferencesHelper.save(
                            "user",
                            _appState!.currentUser,
                          );
                          _navigationState!.upadateNavigationIndex(0);
                          Navigator.pushReplacementNamed(
                            context,
                            '/navigation',
                          );
                        } else {
                          showErrorDialog(results['message'], context);
                        }
                      } catch (e) {
                        print('Error during login: $e');
                        // Continue with login even if token fails
                        _progressIndicatorState!.setIsLoading(true);
                        var results = await _services.get(
                          '${Utils.LOGIN_URL}?user_phone=$_userPhone&user_pass=$_userPassword&token=&lang=${_appState!.currentLang}&key=$cKey',
                        );
                        _progressIndicatorState!.setIsLoading(false);
                        
                        if (results['response'] == '1') {
                          _appState!.setCurrentPhoneSend(_userPhone!);
                          _appState!.setCurrentTokenSend("");
                          showToast(context, message: results['message']);
                          _appState!.setCurrentUser(
                            User.fromJson(results["user_details"]),
                          );
                          SharedPreferencesHelper.save(
                            "user",
                            _appState!.currentUser,
                          );
                          _navigationState!.upadateNavigationIndex(0);
                          Navigator.pushReplacementNamed(
                            context,
                            '/navigation',
                          );
                        } else {
                          showErrorDialog(results['message'], context);
                        }
                      }
                    }
                  },
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(5)),

            Container(
              margin: EdgeInsets.only(right: _width * .05, left: _width * .05),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: Text(
                  " تخطي كزائر",
                  style: TextStyle(color: cOmarColor, fontSize: 14),
                ),
                onTap: () {
                  _navigationState!.upadateNavigationIndex(0);
                  Navigator.pushReplacementNamed(context, '/navigation');
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: Column(
                children: <Widget>[
                  Text(
                    "لو لم يكن لديك حساب",
                    style: TextStyle(color: cOmarColor, fontSize: 14),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "يمكنك التسجيل",
                        style: TextStyle(color: cOmarColor, fontSize: 14),
                      ),
                      Padding(padding: EdgeInsets.all(2)),
                      GestureDetector(
                        child: Text(
                          "من هنا",
                          style: TextStyle(
                            color: cLightLemon,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/register_screen');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
    _navigationState = Provider.of<NavigationState>(context);
    print('lang : ${_appState!.currentLang}');
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),

          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Stack(
                children: <Widget>[
                  _buildBodyItem(),

                  Center(child: ProgressIndicatorComponent()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
