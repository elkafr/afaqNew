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
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';

class ContactWithUsScreen extends StatefulWidget {
  ContactWithUsScreen({Key? key}) : super(key: key);

  @override
  _ContactWithUsScreenState createState() => _ContactWithUsScreenState();
}

class _ContactWithUsScreenState extends State<ContactWithUsScreen> {
  double _height = 0;
  double _width = 0;
  final _formKey = GlobalKey<FormState>();
  String? _userEmail, _messageTitle, _userName, _messageContent;
  Services _services = Services();
  AppState? _appState;
  ProgressIndicatorState? _progressIndicatorState;
  String _facebookUrl = '',
      _instragramUrl = '',
      _linkedinUrl = '',
      _twitterUrl = '';

  FocusNode? _focusNode;

  _launchURL(String url) async {
    launch(url);
  }

  Future<Null> _getSocialContact() async {
    var results = await _services.get(Utils.BASE_URL + 'social');

    if (results['response'] == '1') {
      _facebookUrl = results['setting_facebook'];
      _twitterUrl = results['setting_twitter'];
      _linkedinUrl = results['setting_linkedin'];
      _instragramUrl = results['setting_instigram'];
    } else {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _getSocialContact();
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
            SizedBox(height: _height * 0.1),
            Container(
              height: _height * 0.15,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
              child: Center(child: Image.asset('assets/images/logo.png')),
            ),

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
                left: _width * 0.025,
                right: _width * 0.025,
                bottom: _width * 0.04,
              ),
              child: CustomTextFormField(
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
              margin: EdgeInsets.only(
                left: _width * 0.025,
                right: _width * 0.025,
                bottom: _width * 0.04,
              ),
              child: CustomTextFormField(
                prefixIcon: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.edit, size: 24),
                ),
                hintTxt: AppLocalizations.of(context)!.messageTitle,
                inputData: TextInputType.text,
                maxLines: 15,
                onChangedFunc: (String text) {
                  _messageTitle = text.toString();
                },
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return AppLocalizations.of(context)!.textValidation;
                  }
                  return null;
                },
              ),
            ),

            Container(
              height: 100,
              margin: EdgeInsets.only(
                left: _width * 0.025,
                right: _width * 0.025,
                bottom: _width * 0.04,
              ),
              child: CustomTextFormField(
                prefixIcon: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.edit, size: 24),
                ),
                hintTxt: AppLocalizations.of(context)!.messageDescription,
                inputData: TextInputType.text,
                maxLines: 15,
                onChangedFunc: (String text) {
                  _messageContent = text.toString();
                },
                validationFunc: (value) {
                  if (value!.trim().length == 0) {
                    return AppLocalizations.of(context)!.textValidation;
                  }
                  return null;
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
                      '${Utils.BASE_URL}contact?msg_name=$_userName&msg_email=$_userEmail&msg_title=$_messageTitle&msg_content=$_messageContent&lang=${_appState!.currentLang}',
                    );
                    _progressIndicatorState!.setIsLoading(false);
                    if (results['response'] == '1') {
                      showToast(context, message: results['message']);
                      Navigator.pop(context);
                    } else {
                      showErrorDialog(results['message'], context);
                    }
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.02),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: _width * 0.07,
                        left: _width * 0.02,
                      ),
                      child: Divider(
                        color: Colors.grey[400],
                        height: 2,
                        thickness: 1,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.or,
                      style: TextStyle(
                        color: cBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: _width * 0.07,
                        right: _width * 0.02,
                      ),
                      child: Divider(
                        color: Colors.grey[400],
                        height: 2,
                        thickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: _width * 0.1,
                vertical: _height * 0.02,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _launchURL(_twitterUrl);
                    },
                    child: Image.asset('assets/images/twitter.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL(_linkedinUrl);
                    },
                    child: Image.asset('assets/images/linkedin.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL(_instragramUrl);
                    },
                    child: Image.asset('assets/images/instagram.png'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL(
                        "https://api.whatsapp.com/send?phone=" + _facebookUrl,
                      );
                    },
                    child: Image.asset('assets/images/facebook.png'),
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
                    appBarTitle: AppLocalizations.of(context)!.contactUs,
                    leading: _appState!.currentLang == 'ar'
                        ? IconButton(
                            icon: Image.asset(
                              'assets/images/back.png',
                              color: cWhite,
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
