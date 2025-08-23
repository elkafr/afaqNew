import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/screens/req/req_screen.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class AddReqScreen extends StatefulWidget {
  AddReqScreen({Key? key}) : super(key: key);

  @override
  _AddReqScreenState createState() => _AddReqScreenState();
}

class _AddReqScreenState extends State<AddReqScreen> {
  bool _initialRun = true;
  double _height = 0;
  double _width = 0;
  final _formKey = GlobalKey<FormState>();
  String? _reqValue;
  Services _services = Services();
  AppState? _appState;
  ProgressIndicatorState? _progressIndicatorState;
  String _userCredit = '';

  FocusNode? _focusNode;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> _getUserCredit() async {
    final response = await _services.get(
      "https://mahtco.net/app/api/get_user_credit?user_id=${_appState!.currentUser!.userId}",
    );

    if (response['response'] == '1') {
      setState(() {
        _userCredit = response['user_credit'];
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _getUserCredit();
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode!.dispose();
    super.dispose();
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: _height * 0.16),

            Text(
              "الرصيد الحالي : " + _userCredit + " SR ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: cPrimaryColor,
              ),
            ),
            SizedBox(height: _height * 0.04),
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.02,
                left: _width * 0.025,
                bottom: _width * 0.04,
                right: _width * 0.025,
              ),
              child: CustomTextFormField(
                prefixIcon: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.person, size: 24),
                ),
                hintTxt: "المبلغ المطلوب",
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return "فضلا ادخال المبلغ";
                  }
                  return null;
                },
                inputData: TextInputType.number,
                onChangedFunc: (String text) {
                  _reqValue = text.toString();
                },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              height: 60,
              child: CustomButton(
                btnColor: cLightLemon,
                btnLbl: AppLocalizations.of(context)!.send,
                onPressedFunction: () async {
                  if (_formKey.currentState!.validate()) {
                    _progressIndicatorState!.setIsLoading(true);

                    var results = await _services.get(
                      '${Utils.BASE_URL}send_req?req_value=$_reqValue&user_id=${_appState!.currentUser!.userId}&req_type=${_appState!.currentUser!.userType}&lang=${_appState!.currentLang}',
                    );
                    _progressIndicatorState!.setIsLoading(false);
                    if (results['response'] == '1') {
                      showToast(context, message: results['message']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReqScreen()),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: Color(0xffF5F6F8),
          body: SingleChildScrollView(
            reverse: true,
            child: Stack(
              children: <Widget>[
                _buildBodyItem(),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: GradientAppBar(
                    appBarTitle: "طلب تحويل رصيد",
                    leading: _appState!.currentLang == 'ar'
                        ? IconButton(
                            icon: Image.asset(
                              'assets/images/back.png',
                              color: cPrimaryColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : Container(),
                    trailing: _appState!.currentLang == 'en'
                        ? IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: cWhite),
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
      ),
    );
  }
}
