import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/city.dart';
import 'package:afaq/screens/account/terms_screen.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:validators/validators.dart';
import 'package:afaq/components/drop_down_list_selector/drop_down_list_selector.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double _height = 0;
  double _width = 0;
  final _formKey = GlobalKey<FormState>();
  String _userName = '', _userEmail = '', _userPhone = '', _userPassword = '';
  City? _selectedCity;
  Future<List<City>>? _cityList;
  Services _services = Services();
  ProgressIndicatorState? _progressIndicatorState;
  AppState? _appState;
  NavigationState? _navigationState;
  bool _initialRun = true;

  Future<List<City>> _getCityItems() async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/getcity?lang=${_appState!.currentLang}',
    );
    List<City> cityList = <City>[];
    if (results['response'] == '1') {
      Iterable iterable = results['city'];
      cityList = iterable.map((model) => City.fromJson(model)).toList();
    } else {
      print('error');
    }
    return cityList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);

      _cityList = _getCityItems();
      _initialRun = false;
    }
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: _height * 0.05),
            Container(
              margin: EdgeInsets.only(right: _width * .05, left: _width * .05),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: Text(
                  "تخطي",
                  style: TextStyle(color: cOmarColor, fontSize: 14),
                ),
                onTap: () {
                  _navigationState!.upadateNavigationIndex(0);
                  Navigator.pushReplacementNamed(context, '/navigation');
                },
              ),
            ),

            Container(
              height: _height * 0.19,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
              child: Center(child: Image.asset('assets/images/logo.png')),
            ),
            SizedBox(height: _height * 0.03),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  height: 1.3,
                  fontWeight: FontWeight.w400,
                  color: cBlack,
                  fontSize: 20,
                  fontFamily: 'segoeui',
                ),
                children: <TextSpan>[
                  TextSpan(text: "حياك معنا"),
                  TextSpan(
                    text: ' ! ',
                    style: TextStyle(
                      color: cLightLemon,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: _height * 0.03),
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.03,
                right: _width * .04,
                left: _width * .04,
              ),
              child: CustomTextFormField(
                prefixIcon: Icon(Icons.person, size: 24),

                hintTxt: AppLocalizations.of(context)!.name,
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return AppLocalizations.of(context)!.nameValidation;
                  }
                  return null;
                },
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _userName = text.toString();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.015,
                right: _width * .04,
                left: _width * .04,
              ),
              child: CustomTextFormField(
                iconIsImage: true,
                imagePath: 'assets/images/call.png',
                suffixIcon: Image.asset("assets/images/sa.png"),
                hintTxt: AppLocalizations.of(context)!.phoneNo,
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return AppLocalizations.of(context)!.phonoNoValidation;
                  }

                  if (value.trim().length != 9) {
                    return "يجب ان يكون  رقم الهاتف مكون من 9 ارقايم ويبدء ب 5 ";
                  }
                  return null;
                },
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _userPhone = text.toString();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.015,
                right: _width * .04,
                left: _width * .04,
              ),
              child: CustomTextFormField(
                prefixIcon: Icon(Icons.mail),
                hintTxt: AppLocalizations.of(context)!.email,
                validationFunc: (value) {
                  if (!isEmail(value!)) {
                    return AppLocalizations.of(context)!.emailValidation;
                  }
                  return null;
                },
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _userEmail = text.toString();
                },
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: _height * 0.015,
                right: _width * .02,
                left: _width * .02,
              ),
              child: FutureBuilder<List<City>>(
                future: _cityList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.hasData) {
                      var cityList = snapshot.data!.map((item) {
                        return new DropdownMenuItem<City>(
                          child: new Text(item.cityName!),
                          value: item,
                        );
                      }).toList();

                      return DropDownListSelector(
                        dropDownList: cityList,
                        hint: "المدينة",

                        onChangeFunc: (newValue) {
                          FocusScope.of(context).requestFocus(FocusNode());

                          setState(() {
                            _selectedCity = newValue;
                          });
                        },
                        value: _selectedCity,
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.005,
                right: _width * .04,
                left: _width * .04,
              ),
              child: CustomTextFormField(
                isPassword: true,
                imagePath: 'assets/images/key.png',
                iconIsImage: true,

                hintTxt: AppLocalizations.of(context)!.password,
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _userPassword = text.toString();
                },
                validationFunc: (value) {
                  if (value!.trim().length < 4) {
                    return AppLocalizations.of(context)!.passwordValidation;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.015,
                right: _width * .04,
                left: _width * .04,
              ),
              child: CustomTextFormField(
                isPassword: true,
                imagePath: 'assets/images/key.png',
                iconIsImage: true,
                hintTxt: AppLocalizations.of(context)!.passwordVerify,
                inputData: TextInputType.text,

                validationFunc: (value) {
                  if (value!.trim().length < 4) {
                    return AppLocalizations.of(context)!.passwordValidation;
                  } else if (value != _userPassword) {
                    return AppLocalizations.of(context)!.passwordNotIdentical;
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.025,
                right: _width * .04,
                left: _width * .04,
              ),
              alignment: Alignment.topRight,
              height: _height * 0.05,
              child: Row(
                children: <Widget>[
                  Consumer<AppState>(
                    builder: (context, appState, child) {
                      return GestureDetector(
                        onTap: () {
                          appState.setAcceptTerms(!appState.acceptTerms!);

                          setState(() {});
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(
                            left: _width * 0.02,
                            right: _width * 0.02,
                          ),
                          child: appState.acceptTerms!
                              ? Icon(Icons.check, color: cWhite, size: 17)
                              : Container(),
                          decoration: BoxDecoration(
                            color: appState.acceptTerms!
                                ? cPrimaryColor
                                : cWhite,
                            border: Border.all(
                              color: appState.acceptTerms!
                                  ? cPrimaryColor
                                  : cHintColor,
                            ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      );
                    },
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TermsScreen()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'segoeui',
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                              text: AppLocalizations.of(context)!.iAccept,
                            ),
                            new TextSpan(
                              text: AppLocalizations.of(context)!.terms,
                              style: new TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'segoeui',
                                color: cLightLemon,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              child: CustomButton(
                btnColor: cLightLemon,
                btnLbl: AppLocalizations.of(context)!.register,
                onPressedFunction: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_appState!.acceptTerms!) {
                      _progressIndicatorState!.setIsLoading(true);
                      print('$_userEmail');
                      print('$_userPassword');
                      var results = await _services.get(
                        'https://mahtco.net/app/api/register/?user_name=$_userName&user_phone=$_userPhone&user_email=$_userEmail&user_city=${_selectedCity!.cityId}&user_pass=$_userPassword&lang=${_appState!.currentLang}',
                      );
                      _progressIndicatorState!.setIsLoading(false);
                      if (results['response'] == '1') {
                        showToast(context, message: results['message']);
                        //   _appState.setCurrentUser(User(userId:results['user_id'].toString() ));
                        _appState!.setCurrentPhone111(
                          results['user_id'].toString(),
                        );
                        _appState!.setCurrentPhoneSend(_userPhone);
                        Navigator.pushNamed(
                          context,
                          '/register_code_activation_screen',
                        );
                      } else {
                        showErrorDialog(results['message'], context);
                      }
                    } else {
                      showErrorDialog(
                        AppLocalizations.of(context)!.acceptTerms,
                        context,
                      );
                    }
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: Center(
                child: Text(
                  "لديك حساب بالفعل",
                  style: TextStyle(color: cOmarColor, fontSize: 14),
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                "اضغط هنا",
                style: TextStyle(
                  color: cLightLemon,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login_screen');
              },
            ),
            SizedBox(height: _width * .04),
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
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),
          body: Stack(
            children: <Widget>[
              _buildBodyItem(),

              Center(child: ProgressIndicatorComponent()),
            ],
          ),
        ),
      ),
    );
  }
}
