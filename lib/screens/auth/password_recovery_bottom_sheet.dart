import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';

class PasswordRecoveryBottomSheet extends StatefulWidget {
  @override
  _PasswordRecoveryBottomSheetState createState() =>
      _PasswordRecoveryBottomSheetState();
}

class _PasswordRecoveryBottomSheetState
    extends State<PasswordRecoveryBottomSheet> {
  String _userPhone = '';
  ProgressIndicatorState? _progressIndicatorState;
  Services _services = Services();

  @override
  Widget build(BuildContext context) {
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final appState = Provider.of<AppState>(context);
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: height * 0.02),
              child: Image.asset('assets/images/mail.png'),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.02,
              ),
              child: Text(
                AppLocalizations.of(context)!.sendMessageToMobile,
                style: TextStyle(
                  color: cBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.02),
              child: CustomTextFormField(
                iconIsImage: true,
                imagePath: 'assets/images/call.png',
                hintTxt: AppLocalizations.of(context)!.phoneNo,

                suffixIcon: Image.asset("assets/images/sa.png"),
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
              height: 60,
              child: CustomButton(
                btnLbl: AppLocalizations.of(context)!.send,
                btnColor: cLightLemon,
                onPressedFunction: () async {
                  _progressIndicatorState!.setIsLoading(true);

                  var results = await _services.get(
                    Utils.PASSWORD_RECOVERY_URL +
                        '?user_phone=$_userPhone&lang=${appState.currentLang}',
                  );
                  _progressIndicatorState!.setIsLoading(false);
                  if (results['response'] == '1') {
                    showToast(context, message: results['message']);
                    Navigator.pop(context);
                  } else {
                    showErrorDialog(results['message'], context);
                  }
                },
              ),
            ),
          ],
        ),
        Positioned(
          left: 5,
          top: 5,
          child: IconButton(
            icon: Image.asset('assets/images/cancel.png'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
