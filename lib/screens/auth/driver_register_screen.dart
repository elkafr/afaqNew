import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/custom_text_form_field/validation_mixin.dart';
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

import 'dart:core';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:dio/dio.dart';

class DriverRegisterScreen extends StatefulWidget {
  DriverRegisterScreen({Key? key}) : super(key: key);

  @override
  _DriverRegisterScreenState createState() => _DriverRegisterScreenState();
}

class _DriverRegisterScreenState extends State<DriverRegisterScreen>
    with ValidationMixin {
  double _height = 0;
  double _width = 0;
  final _formKey = GlobalKey<FormState>();
  String _userName = '',
      _userEmail = '',
      _userPhone = '',
      _userIqama = '',
      _userPassword = '';
  City? _selectedCity;
  Future<List<City>>? _cityList;
  Services _services = Services();
  ProgressIndicatorState? _progressIndicatorState;
  AppState? _appState;
  NavigationState? _navigationState;
  bool _initialRun = true;

  File? _imageFile;
  File? _imageFile1;
  File? _imageFile2;
  File? _imageFile3;
  File? _imageFile4;
  File? _imageFile5;

  dynamic _pickImageError;
  final _picker = ImagePicker();
  final _picker1 = ImagePicker();
  final _picker2 = ImagePicker();
  final _picker3 = ImagePicker();
  final _picker4 = ImagePicker();
  final _picker5 = ImagePicker();

  Future<List<City>> _getCityItems() async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/getcity?lang=${_appState!.currentLang!}',
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

  void _onImageButtonPressed(
    ImageSource source, {
    BuildContext? context,
  }) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      _imageFile = File(pickedFile!.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
      print(_pickImageError);
    }
  }

  void _onImageButtonPressed1(
    ImageSource source, {
    BuildContext? context,
  }) async {
    try {
      final pickedFile1 = await _picker1.pickImage(source: source);
      _imageFile1 = File(pickedFile1!.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
      print(_pickImageError);
    }
  }

  void _onImageButtonPressed2(
    ImageSource source, {
    BuildContext? context,
  }) async {
    try {
      final pickedFile2 = await _picker2.pickImage(source: source);
      _imageFile2 = File(pickedFile2!.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
      print(_pickImageError);
    }
  }

  void _onImageButtonPressed3(
    ImageSource source, {
    BuildContext? context,
  }) async {
    try {
      final pickedFile3 = await _picker3.pickImage(source: source);
      _imageFile3 = File(pickedFile3!.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
      print(_pickImageError);
    }
  }

  void _onImageButtonPressed4(
    ImageSource source, {
    BuildContext? context,
  }) async {
    try {
      final pickedFile4 = await _picker4.pickImage(source: source);
      _imageFile4 = File(pickedFile4!.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
      print(_pickImageError);
    }
  }

  void _onImageButtonPressed5(
    ImageSource source, {
    BuildContext? context,
  }) async {
    try {
      final pickedFile5 = await _picker5.pickImage(source: source);
      _imageFile5 = File(pickedFile5!.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
      print(_pickImageError);
    }
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.subject),
                title: new Text('Gallery'),
                onTap: () {
                  _onImageButtonPressed(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () {
                  _onImageButtonPressed(ImageSource.camera, context: context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet1(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.subject),
                title: new Text('Gallery'),
                onTap: () {
                  _onImageButtonPressed1(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () {
                  _onImageButtonPressed1(ImageSource.camera, context: context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet2(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.subject),
                title: new Text('Gallery'),
                onTap: () {
                  _onImageButtonPressed2(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () {
                  _onImageButtonPressed2(ImageSource.camera, context: context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet3(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.subject),
                title: new Text('Gallery'),
                onTap: () {
                  _onImageButtonPressed3(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () {
                  _onImageButtonPressed3(ImageSource.camera, context: context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet4(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.subject),
                title: new Text('Gallery'),
                onTap: () {
                  _onImageButtonPressed4(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () {
                  _onImageButtonPressed4(ImageSource.camera, context: context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _settingModalBottomSheet5(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.subject),
                title: new Text('Gallery'),
                onTap: () {
                  _onImageButtonPressed5(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera'),
                onTap: () {
                  _onImageButtonPressed5(ImageSource.camera, context: context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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

                hintTxt: "اسم المندوب",
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
                suffixIcon: Image.asset("assets/images/sa.png"),
                imagePath: 'assets/images/call.png',
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
                top: _height * 0.002,
                right: _width * .04,
                left: _width * .04,
              ),
              child: CustomTextFormField(
                prefixIcon: Icon(Icons.person, size: 24),

                hintTxt: "رقم الهوية",
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return "من فضلك ادخل رقم الهوية";
                  }

                  if (value.trim().length != 10) {
                    return "رقم الهوية يجب ان يكون 10 ارقام فقط";
                  }
                  return null;
                },
                inputData: TextInputType.number,
                onChangedFunc: (String text) {
                  _userIqama = text.toString();
                },
              ),
            ),

            GestureDetector(
              onTap: () {
                _settingModalBottomSheet(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: _width * .07,
                  left: _width * .07,
                  top: _width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xffF9F9F9)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius:
                          25.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    child: Text(
                      "الصورة الشخصية",
                      style: TextStyle(fontSize: 14, color: cHintColor),
                    ),
                  ),
                  trailing: _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(_imageFile!, fit: BoxFit.fill),
                        )
                      : Icon(Icons.camera_alt, size: 30, color: cHintColor),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                _settingModalBottomSheet1(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: _width * .07,
                  left: _width * .07,
                  top: _width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xffF9F9F9)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius:
                          25.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    child: Text(
                      "صورة  من الهوية",
                      style: TextStyle(fontSize: 14, color: cHintColor),
                    ),
                  ),
                  trailing: _imageFile1 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(_imageFile1!, fit: BoxFit.fill),
                        )
                      : Icon(Icons.camera_alt, size: 30, color: cHintColor),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                _settingModalBottomSheet2(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: _width * .07,
                  left: _width * .07,
                  top: _width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xffF9F9F9)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius:
                          25.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    child: Text(
                      "استمارة السيارة",
                      style: TextStyle(fontSize: 14, color: cHintColor),
                    ),
                  ),
                  trailing: _imageFile2 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(_imageFile2!, fit: BoxFit.fill),
                        )
                      : Icon(Icons.camera_alt, size: 30, color: cHintColor),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                _settingModalBottomSheet3(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: _width * .07,
                  left: _width * .07,
                  top: _width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xffF9F9F9)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius:
                          25.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    child: Text(
                      "رخصة القيادة",
                      style: TextStyle(fontSize: 14, color: cHintColor),
                    ),
                  ),
                  trailing: _imageFile3 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(_imageFile3!, fit: BoxFit.fill),
                        )
                      : Icon(Icons.camera_alt, size: 30, color: cHintColor),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                _settingModalBottomSheet4(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: _width * .07,
                  left: _width * .07,
                  top: _width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xffF9F9F9)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius:
                          25.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    child: Text(
                      "صورة السيارة من الامام",
                      style: TextStyle(fontSize: 14, color: cHintColor),
                    ),
                  ),
                  trailing: _imageFile4 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(_imageFile4!, fit: BoxFit.fill),
                        )
                      : Icon(Icons.camera_alt, size: 30, color: cHintColor),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                _settingModalBottomSheet5(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: _width * .07,
                  left: _width * .07,
                  top: _width * .03,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Color(0xffF9F9F9)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius:
                          25.0, // has the effect of softening the shadow
                      spreadRadius:
                          5.0, // has the effect of extending the shadow
                      offset: Offset(
                        10.0, // horizontal, move right 10
                        10.0, // vertical, move down 10
                      ),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    child: Text(
                      "صورة السيارة من الخلف",
                      style: TextStyle(fontSize: 14, color: cHintColor),
                    ),
                  ),
                  trailing: _imageFile5 != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(_imageFile5!, fit: BoxFit.fill),
                        )
                      : Icon(Icons.camera_alt, size: 30, color: cHintColor),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(
                top: _height * 0.02,
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
                        onTap: () =>
                            appState.setAcceptTerms(!appState.acceptTerms!),
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
                  if (_formKey.currentState!.validate() &
                      checkDriverRegisterValidation(
                        context,
                        imgFile: _imageFile!,
                        imgFile1: _imageFile1!,
                        imgFile2: _imageFile2!,
                        imgFile3: _imageFile3!,
                        imgFile4: _imageFile4!,
                        imgFile5: _imageFile5!,
                        userCity: _selectedCity!,
                      )) {
                    if (_appState!.acceptTerms!) {
                      _progressIndicatorState!.setIsLoading(true);
                      String fileName = (_imageFile != null)
                          ? Path.basename(_imageFile!.path)
                          : "";

                      String fileName1 = (_imageFile1 != null)
                          ? Path.basename(_imageFile1!.path)
                          : "";

                      String fileName2 = (_imageFile2 != null)
                          ? Path.basename(_imageFile2!.path)
                          : "";

                      String fileName3 = (_imageFile3 != null)
                          ? Path.basename(_imageFile3!.path)
                          : "";

                      String fileName4 = (_imageFile4 != null)
                          ? Path.basename(_imageFile4!.path)
                          : "";

                      String fileName5 = (_imageFile5 != null)
                          ? Path.basename(_imageFile5!.path)
                          : "";

                      FormData formData = new FormData.fromMap({
                        "user_name": _userName,
                        "user_phone": _userPhone,
                        "user_email": _userEmail,
                        "user_city": _selectedCity!.cityId,
                        "user_pass": _userPassword,
                        "user_iqama": _userIqama,
                        "lang": _appState!.currentLang,
                        "user_photo": (_imageFile != null)
                            ? await MultipartFile.fromFile(
                                _imageFile!.path,
                                filename: fileName,
                              )
                            : "",
                        "car_front": (_imageFile1 != null)
                            ? await MultipartFile.fromFile(
                                _imageFile1!.path,
                                filename: fileName1,
                              )
                            : "",
                        "iqama_photo": (_imageFile2 != null)
                            ? await MultipartFile.fromFile(
                                _imageFile2!.path,
                                filename: fileName2,
                              )
                            : "",

                        "car_photo": (_imageFile3 != null)
                            ? await MultipartFile.fromFile(
                                _imageFile3!.path,
                                filename: fileName3,
                              )
                            : "",

                        "car_license": (_imageFile4 != null)
                            ? await MultipartFile.fromFile(
                                _imageFile4!.path,
                                filename: fileName4,
                              )
                            : "",

                        "car_back": (_imageFile5 != null)
                            ? await MultipartFile.fromFile(
                                _imageFile5!.path,
                                filename: fileName5,
                              )
                            : "",
                      });

                      final results = await _services.postWithDio(
                        "https://mahtco.net/app/api/register_driver",
                        body: formData,
                      );

                      _progressIndicatorState!.setIsLoading(false);
                      if (results['response'] == '1') {
                        showToast(context, message: results['message']);
                        //  _appState.setCurrentUser(User(userId:results['user_id'].toString() ));
                        _appState!.setCurrentPhone111(
                          results['user_id'].toString(),
                        );
                        Navigator.pushNamed(
                          context,
                          '/register_code_activation1_screen',
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
