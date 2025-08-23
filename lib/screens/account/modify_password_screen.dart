import 'package:flutter/material.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/connectivity/network_indicator.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/components/safe_area/page_container.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:provider/provider.dart';

class ModifyPasswordScreen extends StatefulWidget {
  @override
  _ModifyPasswordScreenState createState() => _ModifyPasswordScreenState();
}

class _ModifyPasswordScreenState extends State<ModifyPasswordScreen> {
  double _height = 0, _width = 0;
  bool _initialRun = true;
  AppState? _appState;
  Services _services = Services();
  String _useroLdPassword = '', _userNewPassword = '', _confirmNewPassword = '';
  ProgressIndicatorState? _progressIndicatorState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _initialRun = false;
    }
  }

  bool _checkValidation(
    BuildContext context, {
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    // if (oldPassword!.trim().length == 0) {
    //   showToast(AppLocalizations.of(context).passwordValidation, context,
    //       color: cRed);
    //   return false;
    // } else if (newPassword.trim().length == 0) {
    //   showToast(AppLocalizations.of(context).passwordValidation, context,
    //       color: cRed);
    //   return false;
    // } else if (confirmNewPassword.trim().length == 0) {
    //   showToast(AppLocalizations.of(context).passwordValidation, context,
    //       color: cRed);
    //   return false;
    // } else
    //  if (confirmNewPassword != newPassword) {
    //   showToast(AppLocalizations.of(context).passwordNotIdentical, context,
    //       color: cRed);
    //   return false;
    // }
    return true;
  }

  Widget _buildBodyItem() {
    return SingleChildScrollView(
      child: Container(
        height: _height,
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            CustomTextFormField(
              // prefixIconIsImage: true,
              // prefixIcon: 'assets/images/key.png',
              isPassword: true,
              hintTxt: "كلمة المرور القديمة",
              inputData: TextInputType.text,
              onChangedFunc: (String text) {
                _useroLdPassword = text.toString();
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CustomTextFormField(
                // prefixIconIsImage: true,
                // prefixIconImagePath:  'assets/images/key.png',
                isPassword: true,
                hintTxt: "كلمة المرور الجديدة",
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _userNewPassword = text.toString();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CustomTextFormField(
                // prefixIconIsImage: true,
                // prefixIconImagePath:  'assets/images/key.png',
                isPassword: true,
                hintTxt: "تأكيد كلمة المرور الجديدة",
                inputData: TextInputType.text,
                onChangedFunc: (String text) {
                  _confirmNewPassword = text.toString();
                },
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomButton(
                btnLbl: "تغيير كلمة المرور",
                onPressedFunction: () async {
                  if (_checkValidation(
                    context,
                    newPassword: _userNewPassword,
                    oldPassword: _useroLdPassword,
                    confirmNewPassword: _confirmNewPassword,
                  )) {
                    _progressIndicatorState?.setIsLoading(true);
                    var results = await _services.get(
                      '${Utils.SLIDER_URL}user_email=${_appState?.currentUser?.userEmail}&user_name=${_appState?.currentUser?.userName}&user_phone=${_appState?.currentUser?.userPhone}&user_id=${_appState?.currentUser?.userId}&lang=${_appState?.currentLang}&user_pass2=$_useroLdPassword&user_pass=$_userNewPassword&user_pass1=$_userNewPassword&key=$cKey',
                    );
                    _progressIndicatorState?.setIsLoading(false);

                    if (results['response'] == '1') {
                      showToast(context, message: results['message']);
                      showToast(context, message: results['message']);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        '/profile_screen',
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
    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        "تغيير كلمة المرور",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: GestureDetector(
        child: Consumer<AppState>(
          builder: (context, appState, child) {
            return appState.currentLang == 'ar'
                ? Image.asset('assets/images/back.png')
                : Image.asset('assets/images/back.png');
          },
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _height =
        MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
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
