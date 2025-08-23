import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:afaq/components/app_repo/app_state.dart';
import 'package:afaq/components/app_repo/location_state.dart';
import 'package:afaq/components/app_repo/payment_state.dart';
import 'package:afaq/components/app_repo/progress_indicator_state.dart';
import 'package:afaq/components/buttons/custom_button.dart';
import 'package:afaq/components/response_handling/response_handling.dart';
import 'package:afaq/models/bank.dart';
import 'package:afaq/services/access_api.dart';
import 'package:afaq/utils/app_colors.dart';
import 'package:afaq/utils/utils.dart';
import 'package:provider/provider.dart';

class Cash extends StatefulWidget {
  @override
  _CashState createState() => _CashState();
}

class _CashState extends State<Cash> {
  double _height = 0, _width = 0;
  ProgressIndicatorState? _progressIndicatorState;
  LocationState? _locationState;
  File? _imageFile;
  dynamic _pickImageError;
  Bank? _selectedBank;
  Services _services = Services();
  Future<List<Bank>>? _bankList;
  bool _initialRun = true;
  AppState? _appState;
  PaymentState? _paymentState;
  final _imagePicker = ImagePicker();
  String _bankName = '', _bankAcount = '', _bankIban = '';

  final _formKey = GlobalKey<FormState>();
  String _accountOwner = '', _accountNo = '', _iban = '', _imgIsDetected = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _paymentState = Provider.of<PaymentState>(context);
      _locationState = Provider.of<LocationState>(context);

      _initialRun = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15)),

              // Container(
              //   width: _width,
              //   margin: EdgeInsets.only(top: 20),
              //   child: CustomTextFormField(
              //       hintTxt: AppLocalizations.of(context).iban,
              //       inputData: TextInputType.number,
              //       onChangedFunc: (String text) {
              //         _iban = text;
              //       },
              //       validationFunc: (value) {
              //         if (_iban.trim().length == 0) {
              //           return AppLocalizations.of(context).ibanValidation;
              //         }
              //         else if()
              //         return null;
              //       }),
              // ),
              Container(
                margin: EdgeInsets.only(
                  left: _width * 0.05,
                  right: _width * 0.05,
                ),
                child: Text(
                  "ييييي",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'HelveticaNeueW23forSKY',
                    color: cBlack,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: _width * 0.07,
                  right: _width * 0.07,
                  bottom: 10,
                ),
                child: CustomButton(
                  btnLbl: "تاكيد الطلب",
                  onPressedFunction: () async {
                    var results = await _services.get(
                      '${Utils.MAKE_ORDER_URL}user_id=${_appState!.currentUser!.userId}&cartt_phone=${_paymentState!.userPhone}&cartt_adress=${_locationState!.address}&cartt_mapx=${_locationState!.locationLatitude}&cartt_mapy=${_locationState!.locationlongitude}&cartt_tawsil=${_appState!.checkedValue}&cartt_tawsil_value=${_appState!.currentTawsil}&lang=${_appState!.currentLang}',
                    );

                    if (results['response'] == '1') {
                      showToast(context, message: results['message']);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/navigation');
                    } else {
                      showErrorDialog(results['message'], context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
