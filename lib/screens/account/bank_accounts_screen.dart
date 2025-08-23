import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/no_data/no_data.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/bank.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../components/app_repo/app_state.dart';

class BankAccountScreen extends StatefulWidget {
  @override
  _BankAccountScreenState createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  double _height = 0, _width = 0;
  bool _initialRun = true;
  late AppState _appState;
  Services _services = Services();
  Future<List<Bank>>? _bankList;

  Future<List<Bank>> _getBankList() async {
    // Map<String, dynamic> results =
    //     await _services.get('${Utils.BANKS_URL}lang=${_appState.currentLang}');
    // List bankList = List<Bank>();
    // if (results['response'] == '1') {
    //   Iterable iterable = results['bank'];
    //   bankList = iterable.map((model) => Bank.fromJson(model)).toList();
    // } else {
    //   showErrorDialog(results['message'], context);
    // }
    return [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _bankList = _getBankList();
      _initialRun = false;
    }
  }

  Widget _buildRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: cBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: cBlack,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyItem() {
    return Container(
      height: _height,
      width: _width,
      child: FutureBuilder<List<Bank>>(
        future: _bankList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        const Radius.circular(15.00),
                      ),
                      border: Border.all(color: cHintColor),
                    ),
                    height: 160,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: cPrimaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: (Radius.circular(15.0)),
                              topRight: (Radius.circular(15.0)),
                            ),
                          ),
                          height: 45,
                          width: _width,
                          child: Center(
                            child: Text(
                              snapshot.data![index].bankTitle ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: cBlack,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: _buildRow(
                            'اسم صاحب الحساب  :   ',
                            snapshot.data![index].bankName ?? "",
                          ),
                        ),
                        _buildRow(
                          'رقم الحساب  :   ',
                          snapshot.data![index].bankAcount ?? "",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: _buildRow(
                            'رقم الايبان   :   ',
                            snapshot.data![index].bankIban ?? "",
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return NoData(message: AppLocalizations.of(context)?.noResults);
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
            child: SpinKitSquareCircle(color: cPrimaryColor, size: 25),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      title: Text(
        "الحساب البنكيي",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: GestureDetector(
        child: Consumer<AppState>(
          builder: (context, appState, child) {
            return appState.currentLang == 'ar'
                ? Image.asset('assets/images/back_ar.png')
                : Image.asset('assets/images/back_en.png');
          },
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(appBar: appBar, body: _buildBodyItem()),
      ),
    );
  }
}
