import 'dart:async';

import 'package:afaq/components/app_repo/navigation_state.dart';
import 'package:afaq/components/app_repo/product_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button1.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/models/product.dart';
import 'package:afaq/screens/home/search_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_data/shared_preferences_helper.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/no_data/no_data.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/models/category.dart';
import 'package:afaq/models/store.dart';
import 'package:afaq/utils/utils.dart';
import 'package:afaq/components/app_repo/store_state.dart';
import 'package:dotted_line/dotted_line.dart';

class Home1Screen extends StatefulWidget {
  Home1Screen({Key? key}) : super(key: key);

  @override
  _Home1ScreenState createState() => _Home1ScreenState();
}

class _Home1ScreenState extends State<Home1Screen> {
  double _height = 0;
  double _width = 0;
  Future<List<Category>>? _categoriesList;
  Future<List<Category>>? _subcategoriesList;
  Future<List<Product>>? _productList;
  Future<List<Product>>? _productListLimit;
  Future<List<Store>>? _storeList;
  Services _services = Services();
  bool _enableSearch = false;
  String _categoryId = '1';
  StoreState? _storeState;
  ProductState? _productState;
  LocationState? _locationState;
  AppState? _appState;
  NavigationState? _navigationState;
  bool _initialRun = true;
  String? _sValue;

  ProgressIndicatorState? _progressIndicatorState;

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

  Future<List<Category>> _getSubCategories() async {
    String language = await SharedPreferencesHelper.getUserLang();
    Map<dynamic, dynamic> results = await _services.get(
      Utils.SUBCATEGORIES_URL +
          language +
          "&cat_id=${_appState!.selectedCat.mtgerCatId}",
    );
    List categoryList = <Category>[];
    if (results['response'] == '1') {
      Iterable iterable = results['cats'];
      categoryList = iterable.map((model) => Category.fromJson(model)).toList();
      categoryList[0].isSelected = true;
    } else {
      print('error');
    }
    return categoryList as FutureOr<List<Category>>;
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
      // categoryList.insert(
      //     0,
      //     Category(
      //         mtgerCatName: 'العروض',
      //         mtgerCatId: '0',
      //         mtgerCatPhoto:
      //             'https://cdn-icons-png.flaticon.com/512/6150/6150436.png' , mtgerCatColor: "#FFFFFF"));
      categoryList[1].isSelected = true;
    } else {
      print('error');
    }
    return categoryList as FutureOr<List<Category>>;
  }

  Future<List<Product>> _getProducts(String? categoryId) async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/show_mtgerr?lang=${_appState!.currentLang!}&page=1&cat_id=${_appState!.selectedCat.mtgerCatId}',
    );
    List<Product> productList = <Product>[];
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      productList = iterable.map((model) => Product.fromJson(model)).toList();
    } else {
      print('error');
    }
    return productList;
  }

  Future<List<Product>> _getProductsLimit(String? categoryId) async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/show_mtgerr_limit?lang=${_appState!.currentLang!}&page=1&cat_id=${_appState!.selectedCat.mtgerCatId}',
    );
    List<Product> productList = <Product>[];
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      productList = iterable.map((model) => Product.fromJson(model)).toList();
    } else {
      print('error');
    }
    return productList;
  }

  Future<List<Product>> _getProductsWithSub(
    String? categoryId,
    String? subId,
  ) async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/show_mtgerr?lang=${_appState!.currentLang!}&page=1&cat_id=${_appState!.selectedCat.mtgerCatId}&sub_id=${_appState!.selectedSub!.mtgerCatId!}',
    );
    List<Product> productList = <Product>[];
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      productList = iterable.map((model) => Product.fromJson(model)).toList();
    } else {
      print('error');
    }
    return productList;
  }

  Future<List<Store>> _getStores(String query) async {
    Map<dynamic, dynamic> results = await _services.get(Utils.BASE_URL + query);
    List<Store> storeList = <Store>[];
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      storeList = iterable.map((model) => Store.fromJson(model)).toList();
      if (_appState!.currentUser != null) {
        // app favourite list on consume on it
        for (int i = 0; i < storeList.length; i++) {
          print(
            'id: ${storeList[i].mtgerId} : favourite ${storeList[i].isAddToFav}',
          );
          _storeState!.setIsFavourite(
            storeList[i].mtgerId!,
            storeList[i].isAddToFav!,
          );
        }
      }
    } else {
      print('error');
    }
    return storeList;
  }

  Widget _buildCategoriesList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<List<Category>>(
          future: _categoriesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<AppState>(
                builder: (context, appState, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _initialRun = true;
                            _appState!.setSelectedCat(snapshot.data![index]);
                            _appState!.setSelectedCatName(
                              snapshot.data![index].mtgerCatName!,
                            );
                            _productList = _getProducts(
                              _appState!.selectedCat.mtgerCatId,
                            );
                            _subcategoriesList = _getSubCategories();
                            _appState!.setSelectedSub(
                              Category(mtgerCatId: "100000000"),
                            );
                            _initialRun = false;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 7,
                          ),
                          decoration: BoxDecoration(
                            color:
                                snapshot.data![index].mtgerCatId ==
                                    _appState!.selectedCat.mtgerCatId
                                ? Colors.white
                                : null,
                            borderRadius:
                                snapshot.data![index].mtgerCatId ==
                                    _appState!.selectedCat.mtgerCatId
                                ? BorderRadius.circular(15.0)
                                : BorderRadius.circular(0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  snapshot.data![index].mtgerCatName!,
                                  style: TextStyle(
                                    color:
                                        snapshot.data![index].mtgerCatId ==
                                            _appState!.selectedCat.mtgerCatId
                                        ? cLightRed
                                        : cBlack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
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
        );
      },
    );
  }

  Widget _buildSubCategoriesList() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<List<Category>>(
          future: _subcategoriesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<AppState>(
                builder: (context, appState, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _initialRun = true;
                            _appState!.setSelectedSub(snapshot.data![index]);
                            _productList = _getProductsWithSub(
                              _appState!.selectedCat.mtgerCatId,
                              _appState!.selectedSub!.mtgerCatId,
                            );
                            _initialRun = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 7,
                          ),
                          decoration: BoxDecoration(
                            color:
                                snapshot.data![index].mtgerCatId ==
                                    _appState!.selectedSub!.mtgerCatId
                                ? cLightRed
                                : null,
                            borderRadius:
                                snapshot.data![index].mtgerCatId ==
                                    _appState!.selectedSub!.mtgerCatId
                                ? BorderRadius.circular(15.0)
                                : BorderRadius.circular(0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  snapshot.data![index].mtgerCatName!,
                                  style: TextStyle(
                                    color:
                                        snapshot.data![index].mtgerCatId ==
                                            _appState!.selectedSub!.mtgerCatId
                                        ? cWhite
                                        : cBlack,
                                    fontSize: 15,
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
        );
      },
    );
  }

  Widget _buildProducts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<List<Product>>(
          future: _productList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                return GridView.builder(
                  primary: true,
                  padding: const EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 3.2 / 5,
                  ),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        //  _productState!.setCurrentProduct(snapshot.data![index]);

                        showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (builder) {
                            return Container(
                              height: _height * .95,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                              left: _width * .04,
                                              top: _width * .04,
                                            ),
                                            child: Image.asset(
                                              'assets/images/close.png',
                                              color: cLightRed,
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Image.network(
                                            snapshot
                                                .data![index]
                                                .adsMtgerPhoto!,
                                            width: _width,
                                            height: _height * .25,
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(8)),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _width * .06,
                                            left: _width * .06,
                                          ),
                                          child: Text(
                                            snapshot
                                                    .data![index]
                                                    .adsMtgerName! +
                                                " / " +
                                                snapshot
                                                    .data![index]
                                                    .adsMtgerColor!,
                                            style: TextStyle(
                                              color: cText,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(3)),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _width * .06,
                                            left: _width * .06,
                                          ),
                                          child: Text(
                                            snapshot
                                                .data![index]
                                                .adsMtgerDetails!,
                                            style: TextStyle(
                                              color: cDarkGrey,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(10)),
                                        snapshot
                                                        .data![index]
                                                        .ads_mtger_price_after_discount !=
                                                    "0" &&
                                                snapshot
                                                        .data![index]
                                                        .ads_mtger_price_after_discount !=
                                                    null
                                            ? Container(
                                                padding: EdgeInsets.only(
                                                  right: _width * .06,
                                                  left: _width * .06,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data![index]
                                                          .adsMtgerPrice!,
                                                      style: TextStyle(
                                                        color: cLightRed,
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                        2,
                                                      ),
                                                    ),
                                                    Text(
                                                      "ريال",
                                                      style: TextStyle(
                                                        color: cText,
                                                        fontSize: 25,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                padding: EdgeInsets.only(
                                                  right: _width * .06,
                                                  left: _width * .06,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data![index]
                                                          .adsMtgerPrice!,
                                                      style: TextStyle(
                                                        color: cLightRed,
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                        2,
                                                      ),
                                                    ),
                                                    Text(
                                                      "ريال",
                                                      style: TextStyle(
                                                        color: cText,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        if (snapshot
                                                    .data![index]
                                                    .ads_mtger_price_after_discount !=
                                                "0" &&
                                            snapshot
                                                    .data![index]
                                                    .ads_mtger_price_after_discount !=
                                                null)
                                          Container(
                                            padding: EdgeInsets.only(
                                              right: _width * .06,
                                              left: _width * .06,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data![index]
                                                      .ads_mtger_price_after_discount,
                                                  style: TextStyle(
                                                    color: cLightRed,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(2),
                                                ),
                                                Text(
                                                  "ريال",
                                                  style: TextStyle(
                                                    color: cText,
                                                    fontSize: 25,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Padding(
                                          padding: EdgeInsets.all(_width * .02),
                                        ),
                                        snapshot.data![index].adsMtgerState ==
                                                "1"
                                            ? CustomButton1(
                                                btnLbl: "اضافة للسلة",
                                                onPressedFunction: () async {
                                                  if (_appState!.currentUser !=
                                                      null) {
                                                    _progressIndicatorState!
                                                        .setIsLoading(true);
                                                    var results =
                                                        await _services.get(
                                                          'https://mahtco.net/app/api/add_cart?user_id=${_appState!.currentUser!.userId}&ads_id=${snapshot.data![index].adsMtgerId}&amountt=1&lang=${_appState!.currentLang}&cart_price=${snapshot.data![index].adsMtgerPriceAfterDiscount == "1" ? snapshot.data![index].ads_mtger_price_after_discount : snapshot.data![index].adsMtgerPrice}',
                                                        );

                                                    //https://mahtco.net/app/api/add_cart?user_id=${_appState!.currentUser!.userId}&ads_id=${snapshot.data![index].adsMtgerId}&amountt=1&lang=${_appState!.currentLang}&cart_price=${snapshot.data![index].adsMtgerPriceAfterDiscount =="1"?snapshot.data![index].ads_mtger_price_after_discount :snapshot.data![index].adsMtgerPrice}
                                                    _progressIndicatorState!
                                                        .setIsLoading(false);
                                                    if (results['response'] ==
                                                        '1') {
                                                      _storeState!
                                                          .setCurrentIsAddToCart(
                                                            1,
                                                          );
                                                      // Navigator.pushNamed(context, '/store_screen');
                                                      showToast(
                                                        context,
                                                        message:
                                                            results['message'],
                                                      );
                                                      Navigator.pop(context);
                                                    } else {
                                                      showErrorDialog(
                                                        results['message'],
                                                        context,
                                                      );
                                                    }
                                                  } else {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/login_screen',
                                                    );
                                                  }
                                                },
                                              )
                                            : Container(
                                                margin: EdgeInsets.only(
                                                  right: _width * .06,
                                                  left: _width * .06,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.red,
                                                      size: 22,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                        2,
                                                      ),
                                                    ),
                                                    Text(
                                                      "نفذت الكمية",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: _width * .06,
                                            left: _width * .06,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(
                                                  _width * .02,
                                                ),
                                              ),
                                              DottedLine(
                                                direction: Axis.horizontal,
                                                alignment: WrapAlignment.center,
                                                lineLength: double.infinity,
                                                lineThickness: 1.0,
                                                dashLength: 4.0,
                                                dashColor: Colors.black,
                                                dashRadius: 4.0,
                                                dashGapLength: 4.0,
                                                dashGapColor:
                                                    Colors.transparent,
                                                dashGapRadius: 0.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                  _width * .02,
                                                ),
                                              ),
                                              Text(
                                                "أقوي توفير",
                                                style: TextStyle(
                                                  color: cText,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(
                                                  _width * .02,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _width * .04,
                                            left: _width * .04,
                                          ),
                                          height: _height * .3,
                                          child: _buildProductsLimit(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(
                          top: 2,
                          left: 2,
                          right: 2,
                          bottom: 0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Color(0xffEBEBEB),
                          ),
                          color: cWhite,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            // Text(_sValue.toString()),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                snapshot.data![index].adsMtgerState == "1"
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/images/plus1.png",
                                          ),
                                        ],
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        height: 28,
                                        child: Text(
                                          "نفذت الكمية",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                Container(
                                  child: Image.network(
                                    snapshot.data![index].adsMtgerPhoto!,
                                    width: _width * .3,
                                    height: _height * .07,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                    right: 0,
                                    left: 0,
                                    top: 3,
                                  ),
                                  child: Text(
                                    snapshot.data![index].adsMtgerName!,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: cText,
                                    ),
                                  ),
                                ),
                                snapshot
                                                .data![index]
                                                .ads_mtger_price_after_discount !=
                                            "0" &&
                                        snapshot
                                                .data![index]
                                                .ads_mtger_price_after_discount !=
                                            null
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              snapshot
                                                  .data![index]
                                                  .adsMtgerPrice!,
                                              style: TextStyle(
                                                color: cLightRed,
                                                fontSize: 15,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(2)),
                                          Container(
                                            child: Text(
                                              "ريال",
                                              style: TextStyle(
                                                color: cText,
                                                fontSize: 15,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              snapshot
                                                  .data![index]
                                                  .adsMtgerPrice!,
                                              style: TextStyle(
                                                color: cLightRed,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(2)),
                                          Container(
                                            child: Text(
                                              "ريال",
                                              style: TextStyle(
                                                color: cText,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                if (snapshot
                                            .data![index]
                                            .ads_mtger_price_after_discount !=
                                        "0" &&
                                    snapshot
                                            .data![index]
                                            .ads_mtger_price_after_discount !=
                                        null)
                                  Container(
                                    padding: EdgeInsets.only(
                                      right: _width * .06,
                                      left: _width * .06,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          snapshot
                                              .data![index]
                                              .ads_mtger_price_after_discount,
                                          style: TextStyle(
                                            color: cLightRed,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(2)),
                                        Text(
                                          "ريال",
                                          style: TextStyle(
                                            color: cText,
                                            fontSize: 15,
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
                    );
                  },
                );
              } else {
                return NoData(message: "لا يوجد نتائج");
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(
              child: SpinKitThreeBounce(color: cPrimaryColor, size: 40),
            );
          },
        );
      },
    );
  }

  Widget _buildProductsLimit() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<List<Product>>(
          future: _productListLimit,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                return GridView.builder(
                  primary: true,
                  padding: const EdgeInsets.all(0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 3 / 5,
                  ),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        //  _productState!.setCurrentProduct(snapshot.data![index]);

                        showModalBottomSheet<dynamic>(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (builder) {
                            return Container(
                              height: _height * .70,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(
                                        context,
                                      ).viewInsets.bottom,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 30,
                                          child: Image.asset(
                                            'assets/images/bottomTop.png',
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Image.network(
                                            snapshot
                                                .data![index]
                                                .adsMtgerPhoto!,
                                            width: _width,
                                            height: _height * .3,
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(8)),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _width * .06,
                                            left: _width * .06,
                                          ),
                                          child: Text(
                                            snapshot
                                                    .data![index]
                                                    .adsMtgerName! +
                                                " / " +
                                                snapshot
                                                    .data![index]
                                                    .adsMtgerColor!,
                                            style: TextStyle(
                                              color: cText,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(15)),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _width * .06,
                                            left: _width * .06,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot
                                                    .data![index]
                                                    .adsMtgerPrice!,
                                                style: TextStyle(
                                                  color: cLightRed,
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(2),
                                              ),
                                              Text(
                                                "ريال",
                                                style: TextStyle(
                                                  color: cText,
                                                  fontSize: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(6)),
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: _width * .06,
                                            left: _width * .06,
                                          ),
                                          child: Text(
                                            snapshot.data![index].adsMtgerName!,
                                            style: TextStyle(
                                              color: cText,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(_width * .04),
                                        ),
                                        snapshot.data![index].adsMtgerState ==
                                                "1"
                                            ? CustomButton1(
                                                btnLbl: "اضافة للسلة",
                                                onPressedFunction: () async {
                                                  if (_appState!.currentUser !=
                                                      null) {
                                                    _progressIndicatorState!
                                                        .setIsLoading(true);
                                                    var results =
                                                        await _services.get(
                                                          'https://mahtco.net/app/api/add_cart?user_id=${_appState!.currentUser!.userId}&ads_id=${snapshot.data![index].adsMtgerId}&amountt=1&lang=${_appState!.currentLang}&cart_price=${snapshot.data![index].adsMtgerPriceAfterDiscount == "1" ? snapshot.data![index].ads_mtger_price_after_discount : snapshot.data![index].adsMtgerPrice}',
                                                        );
                                                    _progressIndicatorState!
                                                        .setIsLoading(false);
                                                    if (results['response'] ==
                                                        '1') {
                                                      _storeState!
                                                          .setCurrentIsAddToCart(
                                                            1,
                                                          );
                                                      // Navigator.pushNamed(context, '/store_screen');
                                                      showToast(
                                                        context,
                                                        message:
                                                            results['message'],
                                                      );
                                                      Navigator.pop(context);
                                                    } else {
                                                      showErrorDialog(
                                                        results['message'],
                                                        context,
                                                      );
                                                    }
                                                  } else {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/login_screen',
                                                    );
                                                  }
                                                },
                                              )
                                            : Container(
                                                margin: EdgeInsets.only(
                                                  right: _width * .06,
                                                  left: _width * .06,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.red,
                                                      size: 22,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                        2,
                                                      ),
                                                    ),
                                                    Text(
                                                      "نفذت الكمية",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 22,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(
                          top: 0,
                          left: 5,
                          right: 5,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.0,
                            color: Color(0xffEBEBEB),
                          ),
                          color: cWhite,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            // Text(_sValue.toString()),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset("assets/images/plus1.png"),
                                  ],
                                ),
                                Container(
                                  child: Image.network(
                                    snapshot.data![index].adsMtgerPhoto!,
                                    width: _width * .3,
                                    height: _height * .10,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                    bottom: 5,
                                    right: 0,
                                    left: 0,
                                  ),
                                  child: Text(
                                    snapshot.data![index].adsMtgerName!,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: cText,
                                    ),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        snapshot.data![index].adsMtgerPrice!,
                                        style: TextStyle(
                                          color: cLightRed,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(2)),
                                    Container(
                                      child: Text(
                                        "ريال",
                                        style: TextStyle(
                                          color: cText,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return NoData(message: "لا يوجد نتائج");
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(
              child: SpinKitThreeBounce(color: cPrimaryColor, size: 40),
            );
          },
        );
      },
    );
  }

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        SizedBox(height: _height * .01),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFF1F2F8), const Color(0xFFF9F9F9)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          height: _height * .12,
          child: Stack(
            children: [
              Container(color: cPrimaryColor, height: _height * .08),
              Positioned(
                top: 35,
                right: _width * .1,
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  width: _width * .8,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [],
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: cWhite,
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
                          borderSide: BorderSide(color: cWhite),
                        ),
                        focusColor: Color(0xffC5C5C5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: cWhite),
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
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            } else {
                              showToast(
                                context,
                                message: "يجب ادخال كلمة للبحث",
                              );
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
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFFF1F2F8), const Color(0xFFF9F9F9)],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          width: _width,
          height: _height * .09,
          child: _buildCategoriesList(),
        ),
        Container(
          color: cWhite,
          width: _width,
          height: _height * .065,
          child: _buildSubCategoriesList(),
        ),
        Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          height: _height * .64,
          child: _buildProducts(),
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _navigationState = Provider.of<NavigationState>(context);
      _productState = Provider.of<ProductState>(context);
      _locationState = Provider.of<LocationState>(context);
      _appState!.setSelectedSub(Category(mtgerCatId: "100000000"));
      if (_appState!.selectedSub!.mtgerCatId != "100000000") {
        _productList = _getProductsWithSub(
          _appState!.selectedCat.mtgerCatId,
          _appState!.selectedSub!.mtgerCatId,
        );
      } else {
        _productList = _getProducts(_appState!.selectedCat.mtgerCatId);
      }
      _productListLimit = _getProductsLimit(_appState!.selectedCat.mtgerCatId);
      _Tawsilfees = _getTawsilfees();
      _RequestMin = _getRequestMin();
      _Vat = _getVat();
      _VatNumber = _getVatNumber();
    }
  }

  @override
  void initState() {
    super.initState();
    _categoriesList = _getCategories();
    _subcategoriesList = _getSubCategories();
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _storeState = Provider.of<StoreState>(context);
    _locationState = Provider.of<LocationState>(context);
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              _buildBodyItem(),
              _enableSearch
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF9F9F9),
                        boxShadow: [],
                      ),
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
                              print(_sValue);
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close, color: cPrimaryColor),
                              onPressed: () {
                                if (_sValue != null) {
                                  _appState!.setSearchValue(_sValue);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SearchScreen(),
                                    ),
                                  );
                                } else {
                                  showToast(
                                    context,
                                    message: "يجب ادخال كلمة للبحث",
                                  );
                                }
                              },
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              size: 24,
                              color: cPrimaryColor,
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
                    )
                  : Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: GradientAppBar(
                        appBarTitle: _appState!.selectedCatName,
                        leading: IconButton(
                          icon: Image.asset(
                            "assets/images/back.png",
                            color: cWhite,
                          ),
                          onPressed: () {
                            _appState!.setCurrentFilter(1);
                            _appState!.setSelectedSub(
                              Category(mtgerCatId: "100000000"),
                            );
                            _appState!.setSelectedCat(
                              Category(mtgerCatId: "100000000"),
                            );
                            _navigationState!.upadateNavigationIndex(0);
                            Navigator.pushNamed(context, '/navigation');
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
