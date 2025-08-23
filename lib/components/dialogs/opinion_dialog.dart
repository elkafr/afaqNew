import 'package:flutter/material.dart';

import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/locale/localization.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';

import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../app_repo/app_state.dart';
import '../app_repo/progress_indicator_state.dart';

class OpinionDialog extends StatefulWidget {
  @override
  _OpinionDialogState createState() => _OpinionDialogState();
}

class _OpinionDialogState extends State<OpinionDialog> {
  double _rating = 0.0;
  Services _services = Services();
  String _userOpinion = '';

  bool _checkValidation(BuildContext context, {required String opinion}) {
    if (opinion.trim().length == 0) {
      showToast(
        context,
        message: AppLocalizations.of(context)!.messageDescription,

        color: Colors.red,
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    final appState = Provider.of<AppState>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          content: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/poprate.png',
                    height: 70,
                    width: 70,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "قم بإضافة تقييمك",
                    style: TextStyle(
                      color: cBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  SmoothStarRating(
                    allowHalfRating: true,
                    onRatingChanged: (v) {
                      _rating = v;
                      setState(() {});
                    },
                    starCount: 5,
                    rating: _rating,
                    size: 30.0,
                    color: Color(0xffFFCE42),
                    borderColor: Color(0xffA5A1A1),
                    spacing: 0.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7, left: 10, right: 10),
                    height: 80,
                    child: CustomTextFormField(
                      prefixIcon: Image.asset(
                        'assets/images/edit.png',
                        height: 20,
                        width: 20,
                      ),
                      // buttonOnTextForm: true,
                      maxLines: 5,
                      onChangedFunc: (String text) {
                        _userOpinion = text;
                      },
                      hintTxt: "اضافة خبرتك",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                      right: 10,
                      left: 10,
                    ),
                    child: CustomButton(
                      height: 35,
                      // buttonOnDialog: true,
                      btnLbl: "اضافة",
                      onPressedFunction: () async {
                        if (_checkValidation(context, opinion: _userOpinion)) {
                          progressIndicatorState.setIsLoading(true);
                          // var results = await _services.get(
                          //     '${Utils.RATE_APP_URL}rate1_user=${appState.currentUser.userId}&lang=${appState.currentLang}&rate1_value=$_rating&rate1_content=${_rating.toString()}');
                          // progressIndicatorState.setIsLoading(false);
                          // if (results['response'] == '1') {
                          //   showToast(context, message: results['message']);
                          //   Navigator.pop(context);
                          //   Navigator.pop(context);
                          //   Navigator.pushReplacementNamed(
                          //       context, '/customer_opinions_screen');
                          // } else {
                          //   showErrorDialog(results['message'], context);
                          // }
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
}
