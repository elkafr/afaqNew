import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/dialogs/opinion_dialog.dart';
import 'package:afaq/components/no_data/no_data.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/models/customer_opinion.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class CustomerOpinionsScreen extends StatefulWidget {
  @override
  _CustomerOpinionsScreenState createState() => _CustomerOpinionsScreenState();
}

class _CustomerOpinionsScreenState extends State<CustomerOpinionsScreen> {
  double _height = 0, _width = 0;
  bool _initialRun = true;
  AppState? _appState;
  Services _services = Services();
  Future<List<CustomerOpinion>>? _customerOpinionList;

  Future<List<CustomerOpinion>> _getCustomerOpinionList() async {
    // Map<dynamic, dynamic> results = await _services
    //     .get('${Utils.CUSTOMER_OPINIONS_URL}lang=${_appState!.currentLang}');
    // List<CustomerOpinion> customerOpinionList = List<CustomerOpinion>();
    // if (results['response'] == '1') {
    //   Iterable iterable = results['results'];
    //   customerOpinionList =
    //       iterable.map((model) => CustomerOpinion.fromJson(model)).toList();
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
      _customerOpinionList = _getCustomerOpinionList();
      _initialRun = false;
    }
  }

  Widget _buildBodyItem() {
    return Container(
      height: _height,
      width: _width,
      child: FutureBuilder<List<CustomerOpinion>>(
        future: _customerOpinionList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Column(
                children: <Widget>[
                  Container(
                    height: _height * 0.7,
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.00),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300] ?? Color(0xff1F61301A),
                                blurRadius: 1.0,
                              ),
                            ],
                            color: cWhite,
                            border: Border.all(
                              color: Color(0xff1F61301A),
                              width: 1.0,
                            ),
                          ),
                          height: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                ),
                                child: Text(
                                  snapshot.data![index].rate1User ?? '',
                                  style: TextStyle(
                                    color: cBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    child: SmoothStarRating(
                                      starCount: 5,
                                      rating: double.parse(
                                        snapshot.data![index].rate1Value ?? "",
                                      ),
                                      size: 20.0,
                                      color: Color(0xffFFCE42),
                                      borderColor: Color(0xffA5A1A1),
                                      spacing: 0.0,
                                    ),
                                  ),
                                  Text(
                                    '( ${snapshot.data![index].rate1Value} )',
                                    style: TextStyle(
                                      color: Color(0xffA5A1A1),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  snapshot.data![index].rate1Content ?? "",
                                  style: TextStyle(
                                    color: cBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  Divider(),
                  Consumer<AppState>(
                    builder: (context, appState, child) {
                      return appState.currentUser != null
                          ? Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: CustomButton(
                                btnLbl: "اضافة مراجعة",
                                onPressedFunction: () async {
                                  showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (_) {
                                      return OpinionDialog();
                                    },
                                  );
                                },
                              ),
                            )
                          : Container();
                    },
                  ),
                ],
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
      centerTitle: true,
      title: Text(
        "اراء العملاء",
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
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar,
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
