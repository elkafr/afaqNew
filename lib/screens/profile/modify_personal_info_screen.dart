import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/city.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:validators/validators.dart';

class ModifyPersonalInformationScreen extends StatefulWidget {
  @override
  _ModifyPersonalInformationScreenState createState() =>
      _ModifyPersonalInformationScreenState();
}

class _ModifyPersonalInformationScreenState
    extends State<ModifyPersonalInformationScreen> {
  var _height, _width;
  final _formKey = GlobalKey<FormState>();
  ProgressIndicatorState? _progressIndicatorState;
  Services _services = Services();
  AppState? _appState;
  String? _userEmail, _userName, _userPhone;
  City? _selectedCity;
  bool _initSelectedCity = true;
  Future<List<City>>? _cityList;

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

  Widget _buildBodyItem() {
    return Consumer<AppState>(
      builder: (buildContext, appState, child) {
        return SingleChildScrollView(
          child: Container(
            height: _height,
            width: _width,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.only(
                      top: _height * 0.03,
                      left: _width * 0.025,
                      right: _width * 0.025,
                    ),
                    child: CustomTextFormField(
                      initialValue: appState.currentUser!.userName,
                      prefixIcon: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Icon(Icons.person, size: 24),
                      ),
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
                  SizedBox(height: _width * .04),
                  Container(
                    margin: EdgeInsets.only(
                      left: _width * 0.025,
                      right: _width * 0.025,
                    ),
                    child: CustomTextFormField(
                      initialValue: appState.currentUser!.userPhone,
                      prefixIcon: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Icon(Icons.phone_in_talk, size: 24),
                      ),
                      hintTxt: AppLocalizations.of(context)!.phoneNo,
                      validationFunc: (value) {
                        if (value!.trim().length == 0) {
                          return AppLocalizations.of(
                            context,
                          )!.phonoNoValidation;
                        }
                        return null;
                      },
                      inputData: TextInputType.text,
                      onChangedFunc: (String text) {
                        _userPhone = text.toString();
                      },
                    ),
                  ),
                  SizedBox(height: _width * .04),
                  Container(
                    margin: EdgeInsets.only(
                      left: _width * 0.025,
                      right: _width * 0.025,
                    ),
                    child: CustomTextFormField(
                      initialValue: appState.currentUser!.userEmail,
                      prefixIcon: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Icon(Icons.mail, size: 24),
                      ),
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
                    margin: EdgeInsets.symmetric(vertical: _height * 0.02),
                    child: FutureBuilder<List<City>>(
                      future: _cityList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.hasData) {
                            var countryList = snapshot.data!.map((item) {
                              return new DropdownMenuItem<City>(
                                child: new Text(item.cityName!),
                                value: item,
                              );
                            }).toList();
                            if (_initSelectedCity) {
                              for (int i = 0; i < snapshot.data!.length; i++) {
                                if (_appState!.currentUser!.userCityName ==
                                    snapshot.data![i].cityName) {
                                  _selectedCity = snapshot.data![i];
                                  break;
                                }
                              }
                              _initSelectedCity = false;
                            }
                            return DropDownListSelector(
                              dropDownList: countryList,
                              hint: "المدينة",
                              onChangeFunc: (newValue) {
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
                    // height: _height * 0.085,
                    // width: _width,
                    // child:   InkWell(
                    //   onTap: (){
                    //      showModalBottomSheet(
                    //                 shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                    //                   topRight: Radius.circular(20)),
                    //                 ),
                    //                 context: context,
                    //                 builder: (builder) {
                    //                   return SelectCountryBottomSheet();
                    //   });
                    //   },
                    //   child: CustomSelector(

                    //     title: Text('الدولة',
                    //     style: TextStyle(
                    //       fontSize: 14,color: Colors.black
                    //     ),),
                    //     icon: Image.asset('assets/images/city.png'),
                    //   ),
                    // ),
                  ),

                  _appState!.currentUser!.userType != "user"
                      ? Container(
                          color: cLightLemon,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(_width * .04),
                          child: Text(
                            "لتعديل اى بيانات اخري يمكنكم التواصل مع الادارة لتعديلها",
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      : Text(""),
                  Spacer(),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(
                      left: _width * 0.025,
                      right: _width * 0.025,
                    ),
                    height: 60,
                    child: CustomButton(
                      btnLbl: AppLocalizations.of(context)!.save,
                      onPressedFunction: () async {
                        if (_formKey.currentState!.validate()) {
                          _progressIndicatorState!.setIsLoading(true);

                          var results = await _services.get(
                            'https://mahtco.net/app/api/profile?user_email=$_userEmail&user_name=$_userName&user_phone=$_userPhone&user_city=${_selectedCity!.cityId}&user_id=${_appState!.currentUser!.userId}&lang=${_appState!.currentLang}',
                          );
                          _progressIndicatorState!.setIsLoading(false);
                          if (results['response'] == '1') {
                            _appState!.updateUserEmail(_userEmail!);
                            _appState!.updateUserName(_userName!);
                            _appState!.updateUserPhone(_userPhone!);
                            _appState!.updateUserCity(_selectedCity!.cityId!);
                            _appState!.updateUserCityName(
                              _selectedCity!.cityName!,
                            );
                            SharedPreferencesHelper.save(
                              "user",
                              _appState!.currentUser,
                            );
                            showToast(context, message: results['message']);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                              context,
                              '/personal_information_screen',
                            );
                          } else {
                            showErrorDialog(results['message'], context);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _userEmail = _appState!.currentUser!.userEmail;
      _userName = _appState!.currentUser!.userName;
      _userPhone = _appState!.currentUser!.userPhone;
      _cityList = _getCityItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);

    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),
          body: Stack(
            children: <Widget>[
              _buildBodyItem(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: AppLocalizations.of(context)!.editInfo,
                  leading: _appState!.currentLang == 'ar'
                      ? IconButton(
                          icon: Image.asset('assets/images/back.png'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : Container(),
                  trailing: _appState!.currentLang == 'en'
                      ? IconButton(
                          icon: Image.asset('assets/images/back.png'),
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
    );
  }
}
