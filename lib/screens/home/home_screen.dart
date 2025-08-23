import 'dart:async';
import 'dart:core';

import 'dart:io';

import 'package:afaq/screens/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:afaq/models/marka.dart';
import 'package:afaq/models/model.dart';
import 'package:afaq/models/type.dart';
import 'package:afaq/screens/home/home1_screen.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/models/category.dart';
import 'package:afaq/utils/utils.dart';
import 'package:afaq/components/app_repo/store_state.dart';
import 'package:afaq/screens/home/components/slider_images.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:image_picker/image_picker.dart';
import 'package:afaq/components/response_handling/response_handling.dart';

import 'package:string_to_color/string_to_color.dart';

import 'package:afaq/components/custom_text_form_field/validation_mixin.dart';

import '../offer/offer_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ValidationMixin {
  dynamic _pickImageError;
  final _picker = ImagePicker();
  final _picker1 = ImagePicker();
  final _picker2 = ImagePicker();
  double _height = 0;
  double _width = 0;
  final _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  Services _services = Services();
  bool _enableSearch = false;
  StoreState? _storeState;
  AppState? _appState;
  NavigationState? _navigationState;
  LocationState? _locationState;
  bool _initialRun = true;

  Marka? _selectedMarka;
  Future<List<Marka>>? _markaList;

  Type? _selectedType;
  Future<List<Type>>? _typeList;

  Model? _selectedModel;
  Future<List<Model>>? _modelList;

  List<String>? _carttNumber;
  String? _selectedCarttNumber;

  ProgressIndicatorState? _progressIndicatorState;
  FocusNode? _focusNode;

  File? _imageFile;
  File? _imageFile1;
  File? _imageFile2;

  String? _carttHikal, _carttDetails1, _carttDetails2, _carttDetails3;
  String? _sValue;

  Future<String>? _Tawsilfees;
  Future<String> _getTawsilfees() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String Tawsilfees = '';
    if (results['response'] == '1') {
      Tawsilfees = results['Tawsilfees'];
    } else {
      print('error');
    }
    return Tawsilfees;
  }

  Future<String>? _RequestMin;
  Future<String> _getRequestMin() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String RequestMin = '';
    if (results['response'] == '1') {
      RequestMin = results['RequestMin'];
      _appState!.setRequestMin(RequestMin);
    } else {
      print('error');
    }
    return RequestMin;
  }

  Future<String>? _Vat;
  Future<String> _getVat() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String Vat = '';
    if (results['response'] == '1') {
      Vat = results['Vat'];
    } else {
      print('error');
    }
    return Vat;
  }

  Future<String>? _VatNumber;
  Future<String> _getVatNumber() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String VatNumber = '';
    if (results['response'] == '1') {
      VatNumber = results['VatNumber'];
    } else {
      print('error');
    }
    return VatNumber;
  }

  Future<int>? _estlam;
  Future<int> _getEstlam() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    int estlam = 0;
    if (results['response'] == '1') {
      estlam = results['estlam'];
      _appState!.setEstlam(estlam);
    } else {
      print('error');
    }
    return estlam;
  }

  Future<String>? _f1;
  Future<String> _getF1() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String f1 = '';
    if (results['response'] == '1') {
      f1 = results['f1'];
      _appState!.setF1(f1);
    } else {
      print('error');
    }
    return f1;
  }

  Future<String>? _f2;
  Future<String> _getF2() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String f2 = '';
    if (results['response'] == '1') {
      f2 = results['f2'];
      _appState!.setF2To(results['f2_to']);
      _appState!.setF3To(results['f3_to']);
      _appState!.setF1To(results['f1_to']);
      _appState!.setCartText(results['reules']);
      _appState!.setF2(f2);
    } else {
      print('error');
    }
    return f2;
  }

  Future<String>? _f3;
  Future<String> _getF3() async {
    var results = await _services.get('https://mahtco.net/app/api/getOmarAli');
    String f3 = '';
    if (results['response'] == '1') {
      f3 = results['f3'];
      _appState!.setF3(f3);
    } else {
      print('error');
    }
    return f3;
  }

  Future<List<Category>>? _categoriesList;
  Future<List<Marka>> _getMarkaItems() async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/getmarka?lang=${_appState!.currentLang}',
    );
    List<Marka> markaList = <Marka>[];
    if (results['response'] == '1') {
      Iterable iterable = results['marka'];
      markaList = iterable.map((model) => Marka.fromJson(model)).toList();
    } else {
      print('error');
    }
    return markaList;
  }

  Future<List<Type>> _getTypeItems(String x) async {
    Map<dynamic, dynamic> results = x == "0"
        ? await _services.get(
            'https://mahtco.net/app/api/gettype?lang=${_appState!.currentLang}&marka_id=0',
          )
        : await _services.get(
            'https://mahtco.net/app/api/gettype?lang=${_appState!.currentLang}&marka_id=$x',
          );
    List<Type> typeList = <Type>[];
    if (results['response'] == '1') {
      Iterable iterable = results['type'];
      typeList = iterable.map((model) => Type.fromJson(model)).toList();
    } else {
      print('error');
    }
    return typeList;
  }

  Future<List<Model>> _getModelItems() async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/getmodel/?lang=${_appState!.currentLang}',
    );
    List<Model> modelList = <Model>[];
    if (results['response'] == '1') {
      Iterable iterable = results['model'];
      modelList = iterable.map((model) => Model.fromJson(model)).toList();
    } else {
      print('error');
    }
    return modelList;
  }

  Future<List<Category>> _getCategories() async {
    String language = await SharedPreferencesHelper.getUserLang();
    Map<dynamic, dynamic> results = await _services.get(
      Utils.CATEGORIES_URL + language,
    );
    List categoryList = <Category>[];
    if (results['response'] == '1') {
      Iterable iterable = results['cats'];
      categoryList = iterable.map((model) => Category.fromJson(model)).toList();
      categoryList.insert(
        0,
        Category(
          mtgerCatName: 'العروض',
          mtgerCatId: '0',
          mtgerCatPhoto:
              'https://cdn-icons-png.flaticon.com/512/6150/6150436.png',
          mtgerCatColor: "#FFFFFF",
        ),
      );
      categoryList[1].isSelected = true;
    } else {
      print('error');
    }
    return categoryList as FutureOr<List<Category>>;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _navigationState = Provider.of<NavigationState>(context);

      _markaList = _getMarkaItems();
      _typeList = _getTypeItems("0");
      _modelList = _getModelItems();
      _carttNumber = ["1", "2", "3"];
      _initialRun = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _categoriesList = _getCategories();
    _Tawsilfees = _getTawsilfees();
    _RequestMin = _getRequestMin();
    _Vat = _getVat();
    _f1 = _getF1();
    _f2 = _getF2();
    _f3 = _getF3();
    _estlam = _getEstlam();
    _VatNumber = _getVatNumber();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode!.dispose();
    super.dispose();
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.subject),
                title: new Text('معرض الصور'),
                onTap: () {
                  _onImageButtonPressed(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('الكاميرا'),
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
                title: new Text('معرض الصور'),
                onTap: () {
                  _onImageButtonPressed1(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('الكاميرا'),
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
                title: new Text('معرض الصور'),
                onTap: () {
                  _onImageButtonPressed2(ImageSource.gallery, context: context);
                  Navigator.pop(context);
                },
              ),
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('الكاميرا'),
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

  Widget _buildBodyItemDriver() {
    return ListView(
      children: <Widget>[
        SizedBox(height: _width * .01),
        Container(margin: EdgeInsets.all(_width * .05), child: SliderImages()),
        SizedBox(height: _width * .04),
        Container(
          child: Text(
            "انت مسجل دخول",
            style: TextStyle(color: cBlack, fontSize: 17),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(height: _width * .04),
        Container(
          child: Text(
            "كـ مندوب",
            style: TextStyle(
              color: cLightLemon,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(height: _width * .08),
        Container(
          child: Text(
            "للاستفادة من خدمات التطبيق يلزمك التسجيل كعميل",
            style: TextStyle(color: cPrimaryColor, fontSize: 13),
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget _buildBodyItemMtger() {
    return ListView(
      children: <Widget>[
        SizedBox(height: _width * .01),
        Container(margin: EdgeInsets.all(_width * .05), child: SliderImages()),
        SizedBox(height: _width * .04),
        Container(
          child: Text(
            "انت مسجل دخول",
            style: TextStyle(color: cBlack, fontSize: 17),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(height: _width * .04),
        Container(
          child: Text(
            "كـ تاجر",
            style: TextStyle(
              color: cLightLemon,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
        SizedBox(height: _width * .08),
        Container(
          child: Text(
            "للاستفادة من خدمات التطبيق يلزمك التسجيل كعميل",
            style: TextStyle(color: cPrimaryColor, fontSize: 13),
          ),
          alignment: Alignment.center,
        ),
      ],
    );
  }

  Widget _buildBodyItem() {
    var carttNumber = _carttNumber!.map((item) {
      return new DropdownMenuItem<String>(child: new Text(item), value: item);
    }).toList();
    return ListView(
      children: <Widget>[
        Container(child: SliderImages()),

        SizedBox(height: _width * .01),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          decoration: BoxDecoration(color: Color(0xffF9F9F9), boxShadow: []),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Color(0xffF9F9F9),
              borderRadius: BorderRadius.circular(23.0),
            ),
            child: TextFormField(
              cursorColor: Color(0xffC5C5C5),
              maxLines: 1,
              onChanged: (text) {
                setState(() {
                  _sValue = text;
                });
              },

              style: TextStyle(
                color: cBlack,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23.0),
                  borderSide: BorderSide(color: Color(0xffF9F9F9)),
                ),
                focusColor: Color(0xffC5C5C5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffC5C5C5)),
                  borderRadius: BorderRadius.circular(25.7),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: cLightRed),
                  onPressed: () {
                    if (_sValue != null) {
                      _appState!.setSearchValue(_sValue);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    } else {
                      showToast(context, message: "يجب ادخال كلمة للبحث");
                    }
                  },
                ),

                hintText: AppLocalizations.of(context)!.search,
                errorStyle: TextStyle(fontSize: 12.0),
                hintStyle: TextStyle(
                  color: Color(0xffC5C5C5),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),

        Container(
          height: _height * .48,
          padding: EdgeInsets.only(right: 10, left: 10),
          child: FutureBuilder<List<Category>>(
            future: _categoriesList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Consumer<AppState>(
                  builder: (context, appState, child) {
                    return GridView.builder(
                      primary: true,
                      padding: const EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        childAspectRatio: 3.3 / 5,
                      ),

                      shrinkWrap: true,

                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (snapshot.data![index].mtgerCatId == "0") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfferScreen(),
                                ),
                              );
                            } else {
                              _appState!.setSelectedCat(snapshot.data![index]);
                              _appState!.setSelectedCatName(
                                snapshot.data![index].mtgerCatName!,
                              );
                              print(_appState!.selectedCat.mtgerCatId);
                              //   print(_appState!.selectedSub!.mtgerCatId!);
                              setState(() {
                                for (
                                  int i = 0;
                                  i < snapshot.data!.length;
                                  i++
                                ) {
                                  snapshot.data![i].isSelected = false;
                                }
                                snapshot.data![index].isSelected = true;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home1Screen(),
                                  ),
                                );
                              });
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 6,
                            ),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorUtils.stringToColor(
                                snapshot.data![index].mtgerCatPhoto!,
                              ),

                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: _height * .03),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Image.network(
                                    snapshot.data![index].mtgerCatPhoto!,
                                    width: _width * .3,
                                    height: _width * .19,
                                  ),
                                ),
                                SizedBox(height: _height * .02),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 1, right: 1),
                                  child: Text(
                                    snapshot.data![index].mtgerCatName!,

                                    style: TextStyle(
                                      color: cWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(
                child: SpinKitSquareCircle(color: cPrimaryColor, size: 25),
              );
            },
          ),
        ),

        Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(right: _width * .04, left: _width * .04),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Color(0xffEBEBEB)),
            color: cWhite,
            borderRadius: BorderRadius.circular(25.0),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 12.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset("assets/images/circle.png"),
              Padding(padding: EdgeInsets.all(3)),

              Text(" الحد الأدني للطلب  :  ", style: TextStyle(fontSize: 13)),
              FutureBuilder<String>(
                future: _RequestMin,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: 13, color: cText),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(
                    child: SpinKitThreeBounce(color: cPrimaryColor, size: 40),
                  );
                },
              ),

              Text(" ريال ", style: TextStyle(fontSize: 13)),
              Spacer(),
              Image.asset("assets/images/tawsil.png"),
              Padding(padding: EdgeInsets.all(3)),
              Text("التوصيل : ", style: TextStyle(fontSize: 13)),
              FutureBuilder<String>(
                future: _Tawsilfees,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _appState!.setCurrentTawsil(int.parse(snapshot.data!));
                    return Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: 13, color: cText),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(
                    child: SpinKitThreeBounce(color: cPrimaryColor, size: 40),
                  );
                },
              ),
              Text(" ريال ", style: TextStyle(fontSize: 13)),
            ],
          ),
        ),
      ],
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

    final appBar = AppBar(
      elevation: 0,
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      leading: Text(""),
      title: Container(child: Text("الرئيسية", style: TextStyle(fontSize: 16))),
    );

    return NetworkIndicator(
      child: PageContainer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            key: _scaffoldKey, // ADD THIS LINE

            appBar: appBar,

            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                _appState!.currentUser != null
                    ? (_appState!.currentUser!.userType == "user"
                          ? _buildBodyItem()
                          : (_appState!.currentUser!.userType == "driver"
                                ? _buildBodyItemDriver()
                                : _buildBodyItemMtger()))
                    : _buildBodyItem(),

                Center(child: ProgressIndicatorComponent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
