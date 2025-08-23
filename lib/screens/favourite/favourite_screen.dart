import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/store_state.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/no_data/no_data.dart';
import 'package:afaq/components/not_registered/not_registered.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/favourite_store.dart';
import 'package:afaq/models/store.dart';
import 'package:afaq/screens/favourite/components/favourite_store_item.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  double _height = 0, _width = 0;
  Future<List<FavouriteStore>>? _storeList;
  Services _services = Services();
  StoreState? _storeState;
  AppState? _appState;
  bool _initialRun = true;

  Future<List<FavouriteStore>> _getFavouriteStores() async {
    Map<dynamic, dynamic> results = await _services.get(
      'https://mahtco.net/app/api/my_fav?user_id=${_appState!.currentUser!.userId}&page=1&lang=${_appState!.currentLang}',
    );
    List<FavouriteStore> storeList = <FavouriteStore>[];
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      storeList = iterable
          .map((model) => FavouriteStore.fromJson(model))
          .toList();
    } else {
      print('error');
    }
    return storeList;
  }

  Widget _buildStores() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<List<FavouriteStore>>(
          future: _storeList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _storeState!.setCurrentStore(
                          Store(
                            mtgerId: snapshot.data![index].mtgerId,
                            mtgerName: snapshot.data![index].mtgerName,
                            mtgerCat: snapshot.data![index].mtgerCat,
                            mtgerAdress: snapshot.data![index].mtgerAdress,
                            mtgerPhoto: snapshot.data![index].mtgerPhoto,
                            isAddToFav: 1,
                          ),
                        );
                        Navigator.pushNamed(context, '/store_screen');
                      },
                      child: Container(
                        width: _width,
                        height: constraints.maxHeight * 0.18,
                        margin: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: cWhite,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: FavouriteStoreItem(
                          favouriteStore: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return NoData(message: AppLocalizations.of(context)!.noResults);
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
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return appState.currentUser != null
            ? ListView(
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    // margin: EdgeInsets.only(top: 7, bottom: 20),
                    height: _height - 100,
                    child: _buildStores(),
                  ),
                ],
              )
            : NotRegistered();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      if (_appState!.currentUser != null) {
        _storeList = _getFavouriteStores();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _storeState = Provider.of<StoreState>(context);
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F2F2),
          body: Stack(
            children: <Widget>[
              _buildBodyItem(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GradientAppBar(
                  appBarTitle: AppLocalizations.of(context)!.favourite,

                  trailing: IconButton(
                    icon: Icon(Icons.notifications_active, color: cWhite),
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications_screen');
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
