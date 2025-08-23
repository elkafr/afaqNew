// import 'package:flutter/material.dart';
// import 'package:afaq/app_repo/app_state.dart';
// import 'package:afaq/app_repo/auth_state.dart';
// import 'package:afaq/app_repo/progress_indicator_state.dart';
// import 'package:afaq/components/buttons/custom_button.dart';
// import 'package:afaq/components/connectivity/network_indicator.dart';
// import 'package:afaq/components/custom_text_form_field/custom_text_form_field.dart';
// import 'package:afaq/components/dialogs/congratulation_dialog.dart';
// import 'package:afaq/components/progress_indicator_component/progress_indicator_component.dart';
// import 'package:afaq/components/response_handling/response_handling.dart';
// import 'package:afaq/components/safe_area/page_container.dart';
// import 'package:afaq/locale/localization.dart';
// import 'package:afaq/services/access_api.dart';
// import 'package:afaq/utils/app_colors.dart';
// import 'package:afaq/utils/utils.dart';
// import 'package:provider/provider.dart';
//
// class AccountActivationScreen extends StatefulWidget {
//   @override
//   _AccountActivationScreenState createState() =>
//       _AccountActivationScreenState();
// }
//
// class _AccountActivationScreenState extends State<AccountActivationScreen> {
//   double _height = 0, _width = 0;
//
//   String _activationCode = '';
//   Services _services = Services();
//   ProgressIndicatorState _progressIndicatorState;
//   AppState _appState;
//   AuthState _authState;
//
//   bool _checkValidation(BuildContext context, {String codeActivation}) {
//     if (codeActivation.trim().length == 0) {
//       showToast(AppLocalizations.of(context).codeActivationValidation, context,
//           color: cRed);
//       return false;
//     }
//     // else if (password.trim().length < 4) {
//     //   showToast(AppLocalizations.of(context).passwordValidation, context,
//     //       color: cRed);
//     //   return false;
//     // }
//     return true;
//   }
//
//   Widget _buildBodyItem() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(
//           height: 50,
//         ),
//         Image.asset(
//           'assets/images/popphone.png',
//           height: 70,
//           width: _width,
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 10),
//           child: Text(
//             AppLocalizations.of(context).activation,
//             style: TextStyle(
//                 color: cBlack, fontSize: 16, fontWeight: FontWeight.w700),
//           ),
//         ),
//         Container(
//           // margin: EdgeInsets.only(top: 10),
//           child: Text(
//             AppLocalizations.of(context).enterCodeToActivateAccount,
//             style: TextStyle(
//                 color: cHintColor, fontSize: 13, fontWeight: FontWeight.w400),
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 20),
//           child: CustomTextFormField(
//             prefixIconIsImage: true,
//             prefixIconImagePath: 'assets/images/edit.png',
//             hintTxt: AppLocalizations.of(context).writeCodeHere,
//             inputData: TextInputType.text,
//             onChangedFunc: (String text) {
//               _activationCode = text.toString();
//             },
//           ),
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 20),
//           child: CustomButton(
//             btnLbl: AppLocalizations.of(context).activation,
//             onPressedFunction: () async {
//               if (_checkValidation(context, codeActivation: _activationCode)) {
//                 _progressIndicatorState.setIsLoading(true);
//                 var results = await _services.get(
//                     '${Utils.REGISTER_CODE_ACTIVATION_URL}user_id=${_authState.userId}&user_code=$_activationCode&lang=${_appState.currentLang}');
//                 _progressIndicatorState.setIsLoading(false);
//                 if (results['response'] == '1') {
//                   showToast(context,message: results['message']);
//           showDialog(context:context,barrierDismissible: true ,builder: (_){
//             return CongratulationDialog()
//             ;
//           });
//
//
//               Future.delayed(const Duration(seconds: 2), () {
//                 Navigator.pop(context);
//                                  Navigator.pushNamed(context, '/login_screen');
//                               });
//
//                 } else {
//                   showErrorDialog(results['message'], context);
//                 }
//               }
//             },
//           ),
//         ),
//         CustomButton(
//             borderColor: cAccentColor,
//             btnStyle: TextStyle(
//                 fontFamily: 'HelveticaNeueW23forSKY',
//                 color: cAccentColor,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 16.0),
//             btnColor: cWhite,
//             btnLbl: AppLocalizations.of(context).notReachAndResend,
//             onPressedFunction: () async {
//                   _progressIndicatorState.setIsLoading(true);
//             var results = await _services.get(
//                     '${Utils.SEND_CODE_URL}user_phone=${_authState.userPhone}&lang=${_appState.currentLang}');
//                 _progressIndicatorState.setIsLoading(false);
//                 if (results['response'] == '1') {
//                   showToast(context,message: results['message']);
//                 } else {
//                   showErrorDialog(results['message'], context);
//                 }
//             })
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(
//         backgroundColor: cPrimaryColor,
//         centerTitle: true,
//         title: Text(AppLocalizations.of(context).accountActivationCode,
//             style: Theme.of(context).textTheme.display1),
//         leading: IconButton(
//           icon: Consumer<AppState>(
//             builder: (context,appState,child){
//               return appState.currentLang == 'ar' ? Image.asset('assets/images/back_ar.png'):
//               Image.asset('assets/images/back_en.png');
//
//             }
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ));
//     _height =
//         MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//     _width = MediaQuery.of(context).size.width;
//     _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
//     _appState = Provider.of<AppState>(context);
//     _authState = Provider.of<AuthState>(context);
//
//     return NetworkIndicator(
//         child: PageContainer(
//       child: Scaffold(
//         resizeToAvoidBottomPadding: false,
//         appBar: appBar,
//         body: Stack(
//           children: <Widget>[
//             _buildBodyItem(),
//             Center(
//               child: ProgressIndicatorComponent(),
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }
